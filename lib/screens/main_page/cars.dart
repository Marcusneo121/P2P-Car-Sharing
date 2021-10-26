import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/car_view.dart';
import 'package:p2p_car_sharing_app/models/car_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
//List<CarModel> carList = [];

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  Future readData() async {
    if (CarList.carList.isEmpty) {
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

          var eachCarModel = CarModel(
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
          CarList.carList.add(eachCarModel);
          print("Car List added");
        });
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewOrNot = CarList.carList.isNotEmpty
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
                      itemCount: CarList.carList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCarCard(context, index, obtainedUID),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.notifications_rounded,
                      size: 27.0,
                    ),
                    onPressed: () {
                      Get.toNamed('/renterRequest');
                    },
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.search_rounded,
                      size: 27,
                    ),
                    onPressed: () {
                      Get.toNamed('/search');
                    },
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

  @override
  void initState() {
    uidShared();
    CarList.carList.clear();
    print("car list cleared");
    readData();
  }

  Future<void> uidShared() async {
    final SharedPreferences stayLoginShared =
        await SharedPreferences.getInstance();
    setState(() {
      obtainedUID = stayLoginShared.get('uidShared').toString();
    });
  }
}
