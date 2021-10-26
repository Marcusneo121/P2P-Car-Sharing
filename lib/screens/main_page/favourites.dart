import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/fav_car_view.dart';
import 'package:p2p_car_sharing_app/models/favorite_car_model.dart';
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
String ownerContact = "";
String ownerEmail = "";
String ownerID = "";
String ownerName = "";
String ownerImage = "";

final _firestore = FirebaseFirestore.instance;

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    obtainedUID = FirebaseAuth.instance.currentUser!.uid;
    FavCarList.favCarList.clear();
    print("car list cleared");
    print(obtainedUID.toString());
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
    if (FavCarList.favCarList.isEmpty) {
      await _firestore
          .collection('users')
          .doc(obtainedUID)
          .collection("favorites")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
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
              ownerContact = doc["ownerContact"];
              ownerEmail = doc["ownerEmail"];
              ownerID = doc["ownerID"];
              ownerName = doc["ownerName"];
              ownerImage = doc["ownerImage"];

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
              //carID = "";
            });

            var eachCarModel = FavCarModel(
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
            FavCarList.favCarList.add(eachCarModel);
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
    Widget listViewOrNot = FavCarList.favCarList.isNotEmpty
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
                      itemCount: FavCarList.favCarList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildFavCarCard(context, index, obtainedUID),
                    );
                  }
                },
              ),
            ),
          )
        : Center(
            child: Column(
              children: [
                SizedBox(height: 200),
                Lottie.asset('assets/favorite.json', width: 160, height: 160),
                Text(
                  "Oops! No favourite yet.",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 7),
                Text(
                  "Find a car you like and Favourite it !",
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
            top: 20.0,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'My Favourite',
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
}
