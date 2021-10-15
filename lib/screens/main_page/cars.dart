import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/components/car_view.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:p2p_car_sharing_app/models/car_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String obtainedUID = "";
String imagePath = "";
String carName = "";
String carPlate = "";
List<String> images = [];
String price = "";
final _firestore = FirebaseFirestore.instance;

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  Future readData() async {
    _firestore.collection('cars').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["carName"]);
        print(doc["carPic"]);
        print(doc["color"]);
        print(doc["engineCapacity"]);
        print(doc["location"]);
        print(doc["plateNumber"]);
        print(doc["price"]);
        print(doc["seat"]);
        print(doc["yearMade"]);
      });
    });

    CarModel(
        imagePath: imagePath,
        carName: carName,
        carPlate: carPlate,
        images: images,
        price: price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.search_rounded,
                      size: 27,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              // Column(
              //   children: <Widget>[
              //     Text(
              //       'Normal Home',
              //       style: TextStyle(fontSize: 20),
              //     ),
              //     Text(
              //       obtainedUID,
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ],
              // ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: CarList.list.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildCarCard(context, index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    uidShared();
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
