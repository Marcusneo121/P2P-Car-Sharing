import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/components/input_widget.dart';
import '../../../constant.dart';

final _firestore = FirebaseFirestore.instance;
String carID = "";
String username = "";
String email = "";

class BookCar extends StatefulWidget {
  const BookCar({Key? key}) : super(key: key);

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  TextEditingController priceController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  String uid = "";
  String? carID,
      carName,
      carPlate,
      price,
      location,
      seat,
      yearMade,
      color,
      engine,
      fromDate,
      toDate,
      renterImage;
  String carPic =
      "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/grayscale-mountain.png?alt=media&token=4e6c1355-6583-4597-a481-7aecd205a2cf";
  DateTime? fromDateValidation;

  @override
  void initState() {
    carID = Get.arguments;
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
    readData();
  }

  readData() async {
    await _firestore
        .collection('cars')
        .doc(carID.toString())
        .get()
        .then((datasnapshot) async {
      setState(() {
        carPic = datasnapshot.get('carPic').toString();
        carName = datasnapshot.get('carName').toString();
        carPlate = datasnapshot.get('plateNumber').toString();
        price = datasnapshot.get('price').toString();
        location = datasnapshot.get('location').toString();
        seat = datasnapshot.get('seat').toString();
        yearMade = datasnapshot.get('yearMade').toString();
        color = datasnapshot.get('color').toString();
        engine = datasnapshot.get('engineCapacity').toString();
        fromDate = datasnapshot.get('fromDate').toString();
        print("$fromDate");
        DateTime.parse(fromDate!).isBefore(DateTime.now())
            ? _dateTime = DateTime.now()
            : _dateTime = DateTime.parse(fromDate!);
        print("$fromDate");
        toDate = datasnapshot.get('toDate').toString();
        DateTime.parse(toDate!).isBefore(DateTime.now())
            ? _dateTime2 = DateTime.now()
            : _dateTime2 = DateTime.parse(toDate!);
      });
    });

    await _firestore
        .collection('users')
        .doc(uid.toString())
        .get()
        .then((datasnapshot) async {
      setState(() {
        username = datasnapshot.get('username').toString();
        email = datasnapshot.get('email').toString();
        renterImage = datasnapshot.get('profilePic').toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
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
                          'Until',
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

  bool _decideEnable(DateTime day) {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    var difference =
        daysBetween(DateTime.parse(fromDate!), DateTime.parse(toDate!));

    DateTime? dateToSubtract;

    if (_dateTime == DateTime.now()) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
          day.isBefore(DateTime.now().add(Duration(days: difference))))) {
        return true;
      }
    } else {
      if ((day.isAfter(DateTime.parse(fromDate!).subtract(Duration(days: 1))) &&
          day.isBefore(
              DateTime.parse(fromDate!).add(Duration(days: difference))))) {
        return true;
      }
    }
    return false;
  }

  bool _decideWhichDayToEnable(DateTime day) {
    var day1 = DateTime.parse("2021-10-18 12:39:32.581509");
    var day2 = DateTime.parse("2021-10-20 12:39:32.581509");

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    var difference =
        daysBetween(DateTime.parse(fromDate!), DateTime.parse(toDate!));

    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: difference))))) {
      return true;
    }
    return false;
  }

  Future<Null> _fromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      selectableDayPredicate: _decideEnable,
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
      lastDate: DateTime(2101),
      selectableDayPredicate: _decideEnable,
    );
    if (picked != null)
      setState(() {
        _dateTime2 = picked;
        print(_dateTime2);
        // fromDateController.text = DateFormat.yMd().format(insuranceDate!);
      });
  }

  bookCarOwnerRequest() async {
    EasyLoading.show(status: "Booking", dismissOnTap: false);
    Map<String, dynamic> renterRequest = {
      "userID": uid,
      "carID": carID,
      "renterEmail": email,
      "renterName": username,
      "renterContact": contactNoController.text.toString(),
      "rentFrom": _dateTime.toString(),
      "rentUntil": _dateTime2.toString(),
      "renterImage": renterImage.toString(),
      "desirePrice": priceController.text.toString(),
      "status": "Requesting"
    };

    DocumentReference documentReference = _firestore
        .collection('cars')
        .doc(carID.toString())
        .collection("renter")
        .doc(uid.toString());

    documentReference.set(renterRequest).then((doc) async {
      await bookCarRenterRequest();
    }).whenComplete(
      () {
        Future.delayed(Duration(seconds: 1)).then((value) async {
          EasyLoading.showSuccess("Car Booked! Wait for owner respond.");
          Future.delayed(Duration(seconds: 3)).then((value) async {
            EasyLoading.dismiss();
            Get.back();
          });
        });
      },
    );
  }

  bookCarRenterRequest() async {
    EasyLoading.show(status: "Booking...", dismissOnTap: false);
    Map<String, dynamic> myRequest = {
      "carID": carID,
      "rentFrom": _dateTime.toString(),
      "rentUntil": _dateTime2.toString(),
      "desirePrice": priceController.text.toString(),
      "status": "Requesting"
    };

    DocumentReference documentReference = _firestore
        .collection('users')
        .doc(uid.toString())
        .collection("myRequest")
        .doc(carID.toString());

    documentReference.set(myRequest).then((doc) {
      print("Finish Added to my request");
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
      child: ListView(
        shrinkWrap: true,
        reverse: true,
        children: [
          Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(color: Colors.white, spreadRadius: 3),
                            // ],
                          ),
                          height: size.height - 720,
                          width: size.width - 290,
                          child: Image.network(carPic.toString()),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$carName $yearMade,',
                              style: pageStyle1.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 3),
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
                                    "$carPlate",
                                    style: pageStyle2CarPlate,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
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
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Text(
                          'Pick up and Returned at : ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                          '$location',
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
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    upperDatePicker(),
                    SizedBox(height: 23),
                    Text(
                      'Your Name : $username',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Your Email : $email',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Your Contact No.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    input('e.g. 0123949393', contactNoController),
                    SizedBox(height: 15),
                    Text(
                      'Original Price : RM $price / per day',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Your Desire Price (RM)',
                      style: TextStyle(
                        fontSize: 15,
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
                      onTap: () async {
                        //Get.toNamed('/carPage');
                        if (contactNoController.text.isEmpty &&
                            priceController.text.isEmpty) {
                          Get.snackbar(
                            "Ensure detail is filled",
                            "Please ensure that Contact No and Desire Price is filled.",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(milliseconds: 1500),
                            isDismissible: false,
                            backgroundColor: Color(0xFF7879F1),
                            margin: EdgeInsets.all(20),
                            animationDuration: Duration(milliseconds: 800),
                            icon: Icon(
                              Icons.announcement_rounded,
                              color: Colors.black,
                            ),
                            shouldIconPulse: false,
                            overlayBlur: 4,
                            overlayColor: Colors.white38,
                          );
                        } else {
                          await bookCarOwnerRequest();
                        }
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
        ].reversed.toList(),
      ),
    );
  }
}
