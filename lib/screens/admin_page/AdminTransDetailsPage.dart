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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(widget.createdAt.toString()),
                Text(widget.transactionID.toString()),
                Text(widget.ownerID.toString()),
                Text(widget.renterID.toString()),
                Text(widget.totalAmount.toString()),
                Text(widget.renterImage.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
