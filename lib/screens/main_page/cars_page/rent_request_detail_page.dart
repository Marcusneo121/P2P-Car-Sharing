import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constant.dart';

final _firestore = FirebaseFirestore.instance;
String obtainedUID = "";
bool favouriteState = false;
String acceptedOrDeclined = "none";
String liveStatus = "";

class RentRequestDetailPage extends StatefulWidget {
  final String imagePath,
      carID,
      carName,
      carPlate,
      price,
      originalPrice,
      location,
      toDate,
      fromDate,
      renterID,
      renterEmail,
      renterContact,
      renterName,
      renterImage,
      status;

  const RentRequestDetailPage(
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
      required this.renterID,
      required this.renterEmail,
      required this.renterContact,
      required this.renterName,
      required this.renterImage,
      required this.status})
      : super(key: key);

  @override
  _RentRequestDetailPageState createState() => _RentRequestDetailPageState();
}

class _RentRequestDetailPageState extends State<RentRequestDetailPage> {
  int _currentIndex = 0;
  Widget? bottomNavButton;

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
        .collection("cars")
        .doc(widget.carID)
        .collection("renter")
        .doc(widget.renterID)
      ..get().then((dataSnapshot) {
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
                              'Rent Request Details',
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
                                        'Renter Desire Price: RM',
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
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Renter Details',
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
                                      widget.renterImage.toString(),
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
                                        widget.renterName,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.60),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.renterEmail,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.60),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.renterContact,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.60),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Center(
                              child: Container(
                                width: 290,
                                height: 1.5,
                                color: Colors.black.withOpacity(0.20),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
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

  lowerPartDetails() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Original Price : RM ${widget.price}',
              //       style: pageStyleOriPrice,
              //     ),
              //     // SizedBox(
              //     //   height: 3,
              //     // ),
              //     Text(
              //       'Per Day',
              //       style: pageStyle3.copyWith(fontSize: 12),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //   ],
              // ),
              InkWell(
                onTap: () {
                  // Get.toNamed('/bookNow', arguments: widget.carID);
                  setState(() {
                    //acceptedOrDeclined = "none";
                    bottomNavButton = acceptedDetails();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fourthColor.withOpacity(0.12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      ' Accept ',
                      style: pageStyle3.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: tertiaryColor),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  // Get.toNamed('/bookNow', arguments: widget.carID);
                  setState(() {
                    bottomNavButton = declinedDetails();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fifthColor.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      ' Decline ',
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

  acceptedDetails() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  // Get.toNamed('/bookNow', arguments: widget.carID);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fourthColor.withOpacity(0.12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      ' Accepted ',
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
}
