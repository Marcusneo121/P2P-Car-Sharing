import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/components/input_widget.dart';
import '../../../constant.dart';

final _firestore = FirebaseFirestore.instance;
String carID = "";

class BookCar extends StatefulWidget {
  const BookCar({Key? key}) : super(key: key);

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    carID = Get.arguments;
    //uidShared();
    readData();
  }

  readData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(), body: getBody());
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

  getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      //title: Text("Book Now", style: TextStyle(color: Colors.black)),
      //backgroundColor: Color(0xFF7477F0),
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }

  getBody() {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'To Book : ',
                    style: pageStyle1.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(color: Colors.white, spreadRadius: 3),
                        // ],
                      ),
                      height: size.height - 660,
                      width: size.width - 70,
                      child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/cars%2FTesla%20Model%20X.png?alt=media&token=c99aabf4-1662-45f8-9cf5-39c8c2a52f18"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Text(
                        'Car Name,',
                        style: pageStyle1.copyWith(
                          fontSize: 18.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Row(
                  //   children: <Widget>[
                  //     Text(
                  //       'Plate Number',
                  //       style: TextStyle(
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.8,
                                color: primaryColor.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 1.2),
                            child: Text(
                              "carPlate",
                              style: pageStyle2CarPlate,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Text(
                        'Pick up and Returned at : ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Text(
                        '13th, Awana Puri Condominium, Cheras',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Text(
                        'Select Your Booking Time : ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  upperDatePicker(),
                  SizedBox(height: 17),
                  Text(
                    'Original Price : RM 98',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    'Your Desire Price (RM)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  input('e.g. 98', priceController),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/carPage');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: fourthColor.withOpacity(0.12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          ' Book Now ',
                          style: pageStyle3.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: tertiaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
