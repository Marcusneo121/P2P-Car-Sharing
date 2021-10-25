import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/renterRequest_view.dart';
import 'package:p2p_car_sharing_app/models/renter_request_model.dart';
import '../../constant.dart';

final _firestore = FirebaseFirestore.instance;
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
    renterID = "",
    renterEmail = "",
    renterContact = "",
    renterName = "",
    renterImage = "",
    status = "";

class RenterRequest extends StatefulWidget {
  const RenterRequest({Key? key}) : super(key: key);
  @override
  _RenterRequestState createState() => _RenterRequestState();
}

class _RenterRequestState extends State<RenterRequest> {
  @override
  Widget build(BuildContext context) {
    Widget listViewOrNot = RenterRequestList.renterList.isNotEmpty
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
                      itemCount: RenterRequestList.renterList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildRenterRequestCard(context, index, uid),
                    );
                  }
                },
              ),
            ),
          )
        : Center(
            child: Column(
              children: [
                SizedBox(height: 180),
                Lottie.asset('assets/nothinghere.json',
                    width: 150, height: 150),
                SizedBox(height: 10),
                Text(
                  "Oops! Nothing here.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          );

    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 5.0,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                listViewOrNot,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future readData() async {
    if (RenterRequestList.renterList.isEmpty) {
      await _firestore
          .collection('users')
          .doc(uid.toString())
          .collection("postedCars")
          .get()
          .then((QuerySnapshot querySnapshotMaster) {
        querySnapshotMaster.docs.forEach((doc) async {
          await _firestore
              .collection('cars')
              .doc(doc.id.toString())
              .collection('renter')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) async {
              setState(() {
                carID = doc["carID"].toString();
                renterID = doc["userID"].toString();
                price = doc["desirePrice"].toString();
                fromDate = doc["rentFrom"].toString();
                toDate = doc["rentUntil"].toString();
                renterContact = doc["renterContact"].toString();
                renterEmail = doc["renterEmail"].toString();
                renterImage = doc["renterImage"].toString();
                renterName = doc["renterName"].toString();
                status = doc["status"].toString();

                print(carID.toString());
                print(renterID.toString());
                print(price.toString());
                print(fromDate.toString());
                print(toDate.toString());
                print(renterContact.toString());
                print(renterEmail.toString());
                print(renterImage.toString());
                print(renterName.toString());
                print(status.toString());
              });

              await _firestore
                  .collection('cars')
                  .doc(carID.toString())
                  .get()
                  .then((dataSnapshot) {
                setState(() {
                  imagePath = dataSnapshot.get('carPic').toString();
                  carName = dataSnapshot.get('carName').toString();
                  carPlate = dataSnapshot.get('plateNumber').toString();
                  originalPrice = dataSnapshot.get('price').toString();
                  location = dataSnapshot.get('location').toString();

                  print(imagePath.toString());
                  print(carName.toString());
                  print(carPlate.toString());
                  print(originalPrice.toString());
                  print(location.toString());
                });
              });

              var eachRenterRequestModel = RenterRequestModel(
                  imagePath: imagePath,
                  carID: carID,
                  carName: carName,
                  carPlate: carPlate,
                  price: price,
                  originalPrice: originalPrice,
                  location: location,
                  fromDate: fromDate,
                  toDate: toDate,
                  renterContact: renterContact,
                  renterEmail: renterEmail,
                  renterID: renterID,
                  renterName: renterName,
                  renterImage: renterImage,
                  status: status);
              RenterRequestList.renterList.add(eachRenterRequestModel);
            });
          });
        });
      }).catchError((onError) {
        print("Oops error $onError");
      });
    } else {
      return;
    }
  }

  void initState() {
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
    RenterRequestList.renterList.clear();
    readData();
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Color(0xffFAFAFA),
      title: Text(
        'Booking Request',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 3),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () {
                //Get.offNamed('/login/homeFast');
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
                size: 20,
              ),
            ),
          )),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
      elevation: 0.0,
      // actions: [
      //   Icon(
      //     Icons.search_rounded,
      //     color: primaryColor,
      //   ),
      //   SizedBox(
      //     width: 20,
      //   ),
      // ],
    );
  }
}
