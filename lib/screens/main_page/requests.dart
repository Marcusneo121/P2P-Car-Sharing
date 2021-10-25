import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/myrequest_car_view.dart';
import 'package:p2p_car_sharing_app/models/my_request_model.dart';

final _firestore = FirebaseFirestore.instance;

List<String> images = [];
String uid = "";
String imagePath = "",
    carID = "",
    carName = "",
    carPlate = "",
    price = "",
    originalPrice = "",
    location = "",
    toDate = "",
    fromDate = "",
    ownerID = "",
    ownerEmail = "",
    ownerName = "",
    ownerImage = "",
    status = "";

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  void initState() {
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
    MyRequestList.myRequestList.clear();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewOrNot = MyRequestList.myRequestList.isNotEmpty
        ? Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('cars').snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Some Error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: MyRequestList.myRequestList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildMyRequestCard(context, index, uid),
                    );
                  }
                },
              ),
            ),
          )
        : Center(
            child: Column(
              children: [
                SizedBox(height: 170),
                Lottie.asset('assets/myrequest.json', width: 230, height: 230),
                Text(
                  "Oops! You got no booking yet.",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 7),
                Text(
                  "Find a car you Like, Book & Drive it !",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          );

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'My Booking',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              listViewOrNot,
            ],
          ),
        ),
      ),
    );
  }

  Future readData() async {
    if (MyRequestList.myRequestList.isEmpty) {
      await _firestore
          .collection('users')
          .doc(uid.toString())
          .collection("myRequest")
          .get()
          .then((QuerySnapshot querySnapshotMaster) {
        querySnapshotMaster.docs.forEach((doc) async {
          carID = doc["carID"].toString();
          price = doc["desirePrice"].toString();
          fromDate = doc["rentFrom"].toString();
          toDate = doc["rentUntil"].toString();
          status = doc["status"].toString();

          await _firestore
              .collection('cars')
              .doc(doc.id.toString())
              .get()
              .then((dataSnapshotMaster) async {
            setState(() {
              imagePath = dataSnapshotMaster.get('carPic').toString();
              carName = dataSnapshotMaster.get('carName').toString();
              carPlate = dataSnapshotMaster.get('plateNumber').toString();
              originalPrice = dataSnapshotMaster.get('price').toString();
              location = dataSnapshotMaster.get('location').toString();
              ownerID = dataSnapshotMaster.get('ownerID').toString();
            });
          });

          await _firestore
              .collection('users')
              .doc(ownerID.toString())
              .get()
              .then((dataSnapshot) {
            setState(() {
              ownerEmail = dataSnapshot.get('email').toString();
              ownerName = dataSnapshot.get('username').toString();
              ownerImage = dataSnapshot.get('profilePic').toString();
            });
          });

          var eachMyRequestModel = MyRequestModel(
              imagePath: imagePath,
              carID: carID,
              carName: carName,
              carPlate: carPlate,
              price: price,
              originalPrice: originalPrice,
              location: location,
              fromDate: fromDate,
              toDate: toDate,
              ownerEmail: ownerEmail,
              ownerID: ownerID,
              ownerName: ownerName,
              ownerImage: ownerImage,
              status: status);

          print(carID.toString());
          print(ownerID.toString());
          print(price.toString());
          print(fromDate.toString());
          print(toDate.toString());
          print(ownerEmail.toString());
          print(ownerImage.toString());
          print(ownerName.toString());
          print(status.toString());
          print(imagePath.toString());
          print(carName.toString());
          print(carPlate.toString());
          print(originalPrice.toString());
          print(location.toString());

          MyRequestList.myRequestList.add(eachMyRequestModel);
        });
      }).catchError((onError) {
        print("Oops error $onError");
      });
    } else {
      return;
    }
  }
}
