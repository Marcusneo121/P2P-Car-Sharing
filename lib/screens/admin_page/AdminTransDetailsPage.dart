import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class AdminTransDetailPage extends StatefulWidget {
  final String transactionID,
      createdAt,
      paymentMethod,
      carID,
      ownerID,
      ownerEmail,
      ownerName,
      ownerImage,
      renterID,
      renterEmail,
      renterName,
      renterImage,
      totalAmount;

  const AdminTransDetailPage(
      {Key? key,
      required this.transactionID,
      required this.createdAt,
      required this.paymentMethod,
      required this.carID,
      required this.ownerID,
      required this.ownerEmail,
      required this.ownerName,
      required this.ownerImage,
      required this.renterID,
      required this.renterEmail,
      required this.renterName,
      required this.renterImage,
      required this.totalAmount})
      : super(key: key);

  @override
  _AdminTransDetailPageState createState() => _AdminTransDetailPageState();
}

class _AdminTransDetailPageState extends State<AdminTransDetailPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    setState(() {
      //uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color(0xffd0d0d0),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Color(0xffd0d0d0),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          onPressed: () {
            Get.back();
          },
          style: NeumorphicStyle(
            color: Color(0xffd0d0d0),
            shadowLightColor: Color(0xFFFFFFFF),
            lightSource: LightSource.topLeft,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 4,
          ),
          padding: const EdgeInsets.only(
              left: 12.0, right: 5.0, bottom: 12.0, top: 10.0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      elevation: 0.0,
    );
  }

  getBody() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'ID : ',
                        style: pageStyle1.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        widget.transactionID,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF03257FF),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Created At',
                              style: pageStyle1.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: SizedBox(
                                height: 1.4,
                                width: 85.0,
                                child: Container(
                                  height: 1.4,
                                  color: Colors.black.withOpacity(0.4),
                                  //decoration: ,
                                ),
                              ),
                            ),
                            Text(
                              widget.createdAt,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Method',
                              style: pageStyle1.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: SizedBox(
                                height: 1.4,
                                width: 60.0,
                                child: Container(
                                  height: 1.4,
                                  color: Colors.black.withOpacity(0.4),
                                  //decoration: ,
                                ),
                              ),
                            ),
                            Text(
                              widget.paymentMethod,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Transaction Description',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Car ID : ',
                          style: pageStyle1.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.carID,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.65),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'From : ',
                        style: pageStyle1.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 15),
                        height: size.height * 0.16,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: [
                            Color(0xFF647dee),
                            Color(0xffb362f9),
                            //Color(0xFF7879F1)
                          ]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.renterImage.toString(),
                              ),
                              radius: 38,
                            ),
                            SizedBox(width: 2),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.renterName,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.renterEmail,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: SizedBox(
                                    height: 1.4,
                                    width: 140.0,
                                    child: Container(
                                      height: 1.4,
                                      color: Colors.white.withOpacity(1),
                                      //decoration: ,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ID : ",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.80),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.renterID,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.80),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 40,
                        color: Colors.black.withOpacity(0.53),
                      ),
                    ],
                  ),
                  Text(
                    'To : ',
                    style: pageStyle1.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 15),
                        height: size.height * 0.16,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: [
                            Color(0xFF647dee),
                            Color(0xffb362f9),
                            //Color(0xFF7879F1)
                          ]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.ownerImage.toString(),
                              ),
                              radius: 38,
                            ),
                            SizedBox(width: 2),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.ownerName,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.ownerEmail,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: SizedBox(
                                    height: 1.4,
                                    width: 140.0,
                                    child: Container(
                                      height: 1.4,
                                      color: Colors.white.withOpacity(1),
                                      //decoration: ,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ID : ",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.80),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.ownerID,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.80),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "Total Amount : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "RM " + widget.totalAmount,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF03257FF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
