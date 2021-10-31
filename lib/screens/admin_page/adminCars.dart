import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/admin/admin_car_view.dart';
import 'package:p2p_car_sharing_app/models/admin/admin_car_model.dart';

String obtainedUID = "";
String imagePath = "";
String carName = "";
String carPlate = "";
List<String> images = [];
String price = "";
String location = "";
String seat = "";
String yearMade = "";
String color = "";
String engine = "";
String fromDate = "";
String toDate = "";
String carID = "";
String ownerID = "";
String ownerEmail = "";
String ownerName = "";
String ownerContact = "";
String ownerImage = "";

final _firestore = FirebaseFirestore.instance;

class AdminCars extends StatefulWidget {
  const AdminCars({Key? key}) : super(key: key);

  @override
  _AdminCarsState createState() => _AdminCarsState();
}

class _AdminCarsState extends State<AdminCars> {
  @override
  void initState() {
    AdminCarList.adminCarList.clear();
    print("Admin Car List cleared");
    readData();
  }

  Future readData() async {
    if (AdminCarList.adminCarList.isEmpty) {
      await _firestore
          .collection('cars')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          print(doc.id);
          setState(() {
            carID = doc.id;
            imagePath = doc["carPic"];
            carName = doc["carName"];
            carPlate = doc["plateNumber"];
            price = doc["price"];
            location = doc["location"];
            seat = doc["seat"];
            yearMade = doc["yearMade"];
            color = doc["color"];
            engine = doc["engineCapacity"];
            fromDate = doc["fromDate"];
            toDate = doc["toDate"];
            ownerID = doc["ownerID"];
            ownerName = doc["ownerName"];
            ownerEmail = doc["ownerEmail"];
            ownerContact = doc["ownerContact"];
            ownerImage = doc["ownerImage"];

            //Car list images
            Map allImages = doc["carImages"];
            List<String> toListImages = [];
            allImages.forEach((key, value) => toListImages.add(value));
            images = toListImages;
          });

          var eachCarModel = AdminCarModel(
              carID: carID,
              imagePath: imagePath,
              carName: carName,
              carPlate: carPlate,
              images: images,
              price: price,
              location: location,
              seat: seat,
              yearMade: yearMade,
              color: color,
              engine: engine,
              fromDate: fromDate,
              toDate: toDate,
              ownerContact: ownerContact,
              ownerEmail: ownerEmail,
              ownerID: ownerID,
              ownerName: ownerName,
              ownerImage: ownerImage);
          AdminCarList.adminCarList.add(eachCarModel);
          print("Car List added");
        });
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewOrNot = AdminCarList.adminCarList.isNotEmpty
        ? Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('transactions').snapshots(),
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
                      itemCount: AdminCarList.adminCarList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildAdminCarCard(context, index),
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
                  "Ooops! No Cars on the platform.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cars',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 21,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              children: [
                listViewOrNot,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
