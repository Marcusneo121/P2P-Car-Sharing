import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/components/button_widget.dart';
import 'package:p2p_car_sharing_app/components/input_widget.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/myCar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant.dart';

class EditCar extends StatefulWidget {
  List<String> obtainedUID = [];

  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final _firestore = FirebaseFirestore.instance;
  String uid = "";
  TextEditingController carBrandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();

  List<String> images = [];
  String carPic =
      "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/grayscale-mountain.png?alt=media&token=4e6c1355-6583-4597-a481-7aecd205a2cf";
  String? carID,
      carName,
      carPlate,
      price,
      location,
      seat,
      yearMade,
      color,
      engine,
      ownerID,
      ownerEmail,
      ownerContact,
      ownerName,
      ownerImage,
      fromDate,
      toDate;

  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color(0xffe3e3e3),
      body: getBody(),
    );
  }

  void initState() {
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid.toString();
      carID = Get.arguments;
    });
    readData();
  }

  readData() async {
    await _firestore
        .collection('cars')
        .doc(carID.toString())
        //.doc(obtainedUID[1].toString())
        .get()
        .then((datasnapshot) async {
      setState(() {
        Map allImages = datasnapshot.get('carImages');
        List<String> toListImages = [];
        allImages.forEach((key, value) => toListImages.add(value));
        print(toListImages);
        images = toListImages;
        carPic = datasnapshot.get('carPic').toString();
        carID = carID.toString();
        carName = datasnapshot.get('carName').toString();
        carPlate = datasnapshot.get('plateNumber').toString();
        price = datasnapshot.get('price').toString();
        location = datasnapshot.get('location').toString();
        seat = datasnapshot.get('seat').toString();
        yearMade = datasnapshot.get('yearMade').toString();
        color = datasnapshot.get('color').toString();
        engine = datasnapshot.get('engineCapacity').toString();
        ownerID = datasnapshot.get('ownerID').toString();
        ownerEmail = datasnapshot.get('ownerEmail').toString();
        ownerContact = datasnapshot.get('ownerContact').toString();
        ownerName = datasnapshot.get('ownerName').toString();
        ownerImage = datasnapshot.get('ownerImage').toString();
        fromDate = datasnapshot.get('fromDate').toString();
        toDate = datasnapshot.get('toDate').toString();

        carBrandController.text = carName.toString();
        yearController.text = yearMade.toString();
        colorController.text = color.toString();
        engineController.text = engine.toString();
        seatController.text = seat.toString();
        carPlateController.text = carPlate.toString();
        _dateTime = DateTime.parse(fromDate.toString());
        _dateTime2 = DateTime.parse(toDate.toString());
        locationController.text = location.toString();
        priceController.text = price.toString();
        contactNoController.text = ownerContact.toString();
      });

      print(images);
      print(carPic);
      print(carID);
      print(carName);
      print(carPlate);
      print(price);
      print(location);
      print(seat);
      print(yearMade);
      print(color);
      print(engine);
      print(ownerID);
      print(ownerEmail);
      print(ownerContact);
      print(ownerName);
      print(ownerImage);
    });
  }

  updateData() {}

  getAppBar() {
    return AppBar(
      backgroundColor: Color(0xffe3e3e3),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 3),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () {
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
    );
  }

  getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36),
          child: Text(
            'Edit Car',
            style: pageTitleStyle,
          ),
        ),
        Expanded(
          child: Container(
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
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      //upperImagePicker(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Container(
                          width: double.infinity,
                          height: 190.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: fourthColor.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  carPic.toString(),
                                  fit: BoxFit.fitWidth,
                                  height: 180,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '*Images are not updatable.*',
                          style: pageStyle1Extra.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Car Brand and Name',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. Honda Civic Type R', carBrandController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Year',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. 2020', yearController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Color',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. White', colorController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Engine Capacity (CC / kWh[Electric])',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. 1500 / 100', engineController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Seat Number',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      input('e.g. 5', seatController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Car Plate Number',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 55,
                        child: TextField(
                          controller: carPlateController,
                          onTap: () async {},
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            fillColor: fourthColor.withOpacity(0.1),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: 'e.g. WQC 2918',
                            hintStyle: TextStyle(
                                color: primaryColor.withOpacity(0.5),
                                fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Car Available Time',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      upperDatePicker(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pick Up & Return Location',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. KLCC', locationController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Price (RM)',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      input('e.g. 98', priceController),
                      SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: Container(
                          width: 290,
                          height: 2,
                          color: Colors.black.withOpacity(0.22),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Text(
                        'Your Details',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Name :   $ownerName',
                        style: pageStyle1.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Email :   $ownerEmail',
                        style: pageStyle1.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Phone No.',
                        style: pageStyle1.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. 0123456785', contactNoController),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          customApplyButton(() async {}),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  physics: BouncingScrollPhysics(),
                )),
          ),
        ),
      ],
    );
  }

  upperDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: fourthColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'From',
                          style: pageStyle3.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _fromDate(context);
                            },
                            child: Text(
                              DateFormat.yMEd().format(_dateTime) == null
                                  ? '28 june,\n9.00 a.m'
                                  : DateFormat('yyyy-MM-dd').format(_dateTime),
                              style: pageStyle3.copyWith(
                                  fontSize: 12,
                                  color: primaryColor.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: fourthColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'To',
                          style: pageStyle3.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _toDate(context);
                            },
                            child: Text(
                              DateFormat.yMEd().format(_dateTime2) == null
                                  ? '28 june,\n9.00 a.m'
                                  : DateFormat('yyyy-MM-dd').format(_dateTime2),
                              style: pageStyle3.copyWith(
                                  fontSize: 12,
                                  color: primaryColor.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Future<Null> _fromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      //selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null)
      setState(() {
        _dateTime = picked;
        print(_dateTime);
        // fromDateController.text = DateFormat.yMd().format(insuranceDate!);
      });
  }

  Future<Null> _toDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        _dateTime2 = picked;
        print(_dateTime2);
        // fromDateController.text = DateFormat.yMd().format(insuranceDate!);
      });
  }

  customApplyButton(function) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: fourthColor.withOpacity(0.12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 14, bottom: 14),
            child: Text(
              'Update',
              style: pageStyle3.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  color: tertiaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
