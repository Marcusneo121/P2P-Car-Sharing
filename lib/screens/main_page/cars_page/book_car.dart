import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';

class BookCar extends StatefulWidget {
  const BookCar({Key? key}) : super(key: key);

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();

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
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  SizedBox(height: 20),
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
                  upperDatePicker()
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
