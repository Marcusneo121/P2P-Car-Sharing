import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:p2p_car_sharing_app/components/my_car_view.dart';
import 'package:p2p_car_sharing_app/models/my_car_model.dart';
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
String carID = "";
String fromDate = "";
String toDate = "";
String ownerContact = "";
String ownerEmail = "";
String ownerID = "";
String ownerName = "";
String ownerImage = "";

final _firestore = FirebaseFirestore.instance;

class MyCar extends StatefulWidget {
  const MyCar({Key? key}) : super(key: key);

  @override
  _MyCarState createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  @override
  void initState() {
    obtainedUID = Get.arguments;
    print(obtainedUID);
    //uidShared();
    MyCarList.myCarList.clear();
    readData();
  }

  Future<void> uidShared() async {
    final SharedPreferences stayLoginShared =
        await SharedPreferences.getInstance();
    setState(() {
      obtainedUID = stayLoginShared.get('uidShared').toString();
    });
  }

  Future readData() async {
    if (MyCarList.myCarList.isEmpty) {
      await _firestore
          .collection('users')
          .doc(obtainedUID)
          .collection("postedCars")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          // setState(() {
          //   carID = doc["carID"];
          //   print(carID);
          // });
          print(doc["carID"]);
          print(doc.id);
          _firestore
              .collection("cars")
              .doc(doc["carID"])
              .get()
              .then((doc) async {
            print(doc["carName"]);
            print(doc["carPic"]);
            print(doc["color"]);
            print(doc["engineCapacity"]);
            print(doc["location"]);
            print(doc["plateNumber"]);
            print(doc["price"]);
            print(doc["seat"]);
            print(doc["yearMade"]);
            print(doc["toDate"]);
            print(doc["fromDate"]);

            setState(() {
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
              ownerContact = doc["ownerContact"];
              ownerEmail = doc["ownerEmail"];
              ownerID = doc["ownerID"];
              ownerName = doc["ownerName"];

              print(doc["carName"]);
              print(doc["carPic"]);
              print(doc["color"]);
              print(doc["engineCapacity"]);
              print(doc["location"]);
              print(doc["plateNumber"]);
              print(doc["price"]);
              print(doc["seat"]);
              print(doc["yearMade"]);
              print(doc["toDate"]);
              print(doc["fromDate"]);

              //Car list images
              Map allImages = doc["carImages"];
              List<String> toListImages = [];
              allImages.forEach((key, value) => toListImages.add(value));
              print(toListImages);
              images = toListImages;
              carID = "";
            });

            var eachCarModel = MyCarModel(
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
              ownerImage: ownerImage,
            );
            MyCarList.myCarList.add(eachCarModel);
            print("Car List added");
          });
        });
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        MyCarList.myCarList.clear();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF7477F0),
          title: Text('My Car'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                Get.toNamed('/login/home/profile/myCar/addCar');
              },
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: buildBody(),
          ),
        ),
      ),
    );
  }
}

Widget buildBody() => Container(
      child: Column(
        children: <Widget>[
          Expanded(
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
                    itemCount: MyCarList.myCarList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildMyCarCard(context, index),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
