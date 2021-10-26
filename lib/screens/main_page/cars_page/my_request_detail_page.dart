import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/controllers/launcherController.dart';
import '../../../constant.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;
bool favouriteState = false;
String acceptedOrDeclined = "none";
String liveStatus = "";
String uid = "";

class MyRequestDetailPage extends StatefulWidget {
  final String imagePath,
      carID,
      carName,
      carPlate,
      price,
      originalPrice,
      location,
      toDate,
      fromDate,
      ownerID,
      ownerEmail,
      ownerName,
      ownerImage,
      status;

  const MyRequestDetailPage(
      {Key? key,
      required this.imagePath,
      required this.carID,
      required this.carName,
      required this.carPlate,
      required this.price,
      required this.originalPrice,
      required this.location,
      required this.toDate,
      required this.fromDate,
      required this.ownerID,
      required this.ownerEmail,
      required this.ownerName,
      required this.ownerImage,
      required this.status})
      : super(key: key);

  @override
  _MyRequestDetailPageState createState() => _MyRequestDetailPageState();
}

class _MyRequestDetailPageState extends State<MyRequestDetailPage> {
  int _currentIndex = 0;
  Widget? bottomNavButton;

  Map<String, dynamic>? paymentIntentData;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    //obtainedUID = Get.arguments;
    //acceptedOrDeclined = "none";
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
    readAcceptDecline();
    // setState(() {
    //   bottomNavButton = lowerPartDetails();
    // });
    // if (acceptedOrDeclined == "none") {
    //   setState(() {
    //     bottomNavButton = lowerPartDetails();
    //   });
    // } else if (acceptedOrDeclined == "accepted") {
    //   setState(() {
    //     bottomNavButton = acceptedDetails();
    //   });
    // } else if (acceptedOrDeclined == "declined") {
    //   setState(() {
    //     bottomNavButton = declinedDetails();
    //   });
    // }
  }

  readAcceptDecline() {
    _firestore
        .collection("users")
        .doc(uid.toString())
        .collection("myRequest")
        .doc(widget.carID)
        .get()
        .then((dataSnapshot) {
      setState(() {
        liveStatus = dataSnapshot.get('status').toString();
        if (liveStatus == "Requesting") {
          bottomNavButton = lowerPartDetails();
        } else if (liveStatus == "Accepted") {
          bottomNavButton = acceptedDetails();
        } else if (liveStatus == "Declined") {
          bottomNavButton = declinedDetails();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          favouriteState = false;
        });
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getAppBar(),
        backgroundColor: Color(0xffe3e3e3),
        body: getBody(),
      ),
    );
  }

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
    Size size = MediaQuery.of(context).size;
    // bottomNavButton =
    //     accepted == false ? lowerPartDetails() : acceptedDetails();
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
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image(
                      image: NetworkImage(widget.imagePath),
                      height: 120,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.carName,
                              style: pageTitleStyle,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.9,
                                      color: primaryColor.withOpacity(0.6)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    widget.carPlate,
                                    style: pageStyle2,
                                  ),
                                )),
                            SizedBox(
                              height: size.height * 0.003,
                            ),
                            Text(
                              "Original Price : RM " + widget.originalPrice,
                              style: pageStyle2OriPrice,
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Text(
                              'Pick-Up & Return Location',
                              style: pageStyle3.copyWith(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: primaryColor.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.location_on_outlined,
                                        color: tertiaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                            style: pageStyle3.copyWith(
                                                fontSize: 14),
                                            text: widget.location),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Text(
                              'My Request Details',
                              style: pageStyle3.copyWith(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: upperDatePicker(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 13),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'My Desire Price: RM',
                                        style: pageStyle3.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.price,
                                        style: pageStyle3.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF787878),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Status : ',
                                        style: pageStyle3.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.status,
                                        style: pageStyle3.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff0ab31d)
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Container(
                                width: 290,
                                height: 1.5,
                                color: Colors.black.withOpacity(0.20),
                              ),
                            ),
                            SizedBox(height: 23),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Owner Details',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.70),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 8),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.ownerImage.toString(),
                                    ),
                                    radius: 33,
                                  ),
                                  SizedBox(width: 22),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.ownerName,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.60),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          widget.ownerEmail,
                                          style: TextStyle(
                                              color: tertiaryColor
                                                  .withOpacity(0.90),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () => LaunchUtils.openEmail(
                                            toEmail: widget.ownerEmail,
                                            subject: widget.carName +
                                                " Car Rent Inquiry"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              physics: BouncingScrollPhysics(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                child: bottomNavButton,
              ),
            ),
          ),
        ],
      ),
    );
  }

  fromDateWidget() {
    return Expanded(
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
                        //_fromDate(context);
                      },
                      child: Text(
                        DateFormat.yMEd()
                                    .format(DateTime.parse(widget.fromDate)) ==
                                null
                            ? '28 june,\n9.00 a.m'
                            : DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(widget.fromDate)),
                        style: pageStyle3.copyWith(
                            fontSize: 12, color: primaryColor.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  untilDateWidget() {
    return Expanded(
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
                        //_toDate(context);
                      },
                      child: Text(
                        DateFormat.yMEd()
                                    .format(DateTime.parse(widget.toDate)) ==
                                null
                            ? '28 june,\n9.00 a.m'
                            : DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(widget.toDate)),
                        style: pageStyle3.copyWith(
                            fontSize: 12, color: primaryColor.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                              //_fromDate(context);
                            },
                            child: Text(
                              DateFormat.yMEd().format(
                                          DateTime.parse(widget.fromDate)) ==
                                      null
                                  ? '28 june,\n9.00 a.m'
                                  : DateFormat('yyyy-MM-dd')
                                      .format(DateTime.parse(widget.fromDate)),
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
                              //_toDate(context);
                            },
                            child: Text(
                              DateFormat.yMEd().format(
                                          DateTime.parse(widget.toDate)) ==
                                      null
                                  ? '28 june,\n9.00 a.m'
                                  : DateFormat('yyyy-MM-dd')
                                      .format(DateTime.parse(widget.toDate)),
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

  setAccept() {
    Map<String, dynamic> carDetails = {
      "carID": widget.carID.toString(),
      "desirePrice": widget.price.toString(),
      "rentFrom": widget.fromDate.toString(),
      "rentUntil": widget.toDate.toString(),
      "renterEmail": widget.ownerEmail.toString(),
      "renterImage": widget.ownerImage.toString(),
      "renterName": widget.ownerName.toString(),
      "status": "Accepted",
      "userID": widget.ownerID.toString(),
    };

    DocumentReference documentReference = _firestore
        .collection("cars")
        .doc(widget.carID)
        .collection("renter")
        .doc(widget.ownerID);

    documentReference.set(carDetails).then((doc) {
      //addPostedCar(carID.toString());
    }).whenComplete(
      () {
        setState(() {
          bottomNavButton = acceptedDetails();
        });
        Future.delayed(Duration(seconds: 1)).then((value) async {
          EasyLoading.showSuccess("Accepted!");
          Future.delayed(Duration(seconds: 2)).then((value) async {
            EasyLoading.dismiss();
            Get.offNamed("/carPage");
          });
        });
      },
    );
  }

  setDecline() {
    Map<String, dynamic> renterDetails = {
      "carID": widget.carID.toString(),
      "desirePrice": widget.price.toString(),
      "rentFrom": widget.fromDate.toString(),
      "rentUntil": widget.toDate.toString(),
      "renterEmail": widget.ownerEmail.toString(),
      "renterImage": widget.ownerImage.toString(),
      "renterName": widget.ownerName.toString(),
      "status": "Declined",
      "userID": widget.ownerID.toString(),
    };

    DocumentReference documentReference = _firestore
        .collection("cars")
        .doc(widget.carID)
        .collection("renter")
        .doc(widget.ownerID);

    documentReference.set(renterDetails).then((doc) async {
      await setMyRequestDecline();
    }).whenComplete(
      () {
        setState(() {
          bottomNavButton = declinedDetails();
        });
        Future.delayed(Duration(seconds: 1)).then((value) async {
          EasyLoading.showSuccess("Declined!");
          Future.delayed(Duration(seconds: 2)).then((value) async {
            EasyLoading.dismiss();
            Get.offNamed("/carPage");
          });
        });
      },
    );
  }

  setMyRequestDecline() {
    Map<String, dynamic> myRequestDetails = {
      "carID": widget.carID.toString(),
      "desirePrice": widget.price.toString(),
      "rentFrom": widget.fromDate.toString(),
      "rentUntil": widget.toDate.toString(),
      "status": "Declined",
    };

    DocumentReference documentReference = _firestore
        .collection("users")
        .doc(widget.ownerID)
        .collection("myRequest")
        .doc(widget.carID);
    documentReference.set(myRequestDetails).whenComplete(
      () {
        print("Decline My Request Complete");
      },
    );
  }

  lowerPartDetails() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.snackbar(
                    "Request Pending",
                    "Your request is pending for review by the owner. The owner will get back to you soon.",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(milliseconds: 2000),
                    isDismissible: true,
                    backgroundColor: Color(0xFF7879F1),
                    margin: EdgeInsets.all(20),
                    animationDuration: Duration(milliseconds: 800),
                    icon: Icon(
                      Icons.announcement_rounded,
                      color: Colors.black,
                    ),
                    shouldIconPulse: true,
                    overlayBlur: 4,
                    overlayColor: Colors.white38,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fourthColor.withOpacity(0.12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      ' Wait Respond ',
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
    );
  }

  acceptedDetails() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                SizedBox(height: 25),
                Image.asset(
                  'assets/stripe.png',
                  width: 140.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                // Get.toNamed('/bookNow', arguments: widget.carID);
                await makePayment();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: fourthColor.withOpacity(0.12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Text(
                    ' Pay Now ',
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
      ],
    );
  }

  declinedDetails() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  // Get.toNamed('/bookNow', arguments: widget.carID);
                  Get.snackbar(
                    "Your request has been declined.",
                    "Try submit new request. Maybe try higher offer.",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(milliseconds: 2000),
                    isDismissible: true,
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
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fifthColor.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      ' Declined ',
                      style: pageStyle3.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: fifthColor.withOpacity(0.6)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(widget.price + '00', 'MYR');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.light,
            merchantCountryCode: 'MYR',
            merchantDisplayName: 'Carro P2P'),
      );
      displayPaymentSheet();
    } catch (e) {
      print('Exception' + e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData!['client_secret'],
          confirmPayment: true,
        ),
      );

      setState(() {
        paymentIntentData = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Paid Successfully"),
        ),
      );
    } on StripeException catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cancelled!"),
        ),
      );
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      String finalAmount = '$amount.00';

      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51JofQJF0ihJ2wcebdQ6f1wDpCNJ1VA0rfcMYOViljcZkMPvJYuDyNcJ24Netljs0ZbOArK15RasXCsBWReYWEUsy00hJ6oqLKx',
            'Content-Type': 'application/x-www-form-urlencoded',
          });

      return jsonDecode(response.body.toString());
    } catch (e) {
      print('Exception' + e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price;
  }
}
