import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars.dart';
import '../../../constant.dart';

final _firestore = FirebaseFirestore.instance;
String obtainedUID = "";
bool favouriteState = false;

class CarDetailPage extends StatefulWidget {
  final List<String> images;
  final String carID,
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
      ownerImage;

  const CarDetailPage(
      {Key? key,
      required this.carID,
      required this.images,
      required this.carName,
      required this.carPlate,
      required this.price,
      required this.location,
      required this.seat,
      required this.yearMade,
      required this.color,
      required this.engine,
      required this.ownerID,
      required this.ownerEmail,
      required this.ownerContact,
      required this.ownerName,
      required this.ownerImage})
      : super(key: key);

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    obtainedUID = Get.arguments;
    //uidShared();
    readFavourite();
  }
  // Future<void> uidShared() async {
  //   final SharedPreferences stayLoginShared =
  //       await SharedPreferences.getInstance();
  //   setState(() {
  //     obtainedUID = stayLoginShared.get('uidShared').toString();
  //   });
  // }

  bookmark() async {
    Map<String, dynamic> favouriteCar = {
      "carID": widget.carID,
    };

    await _firestore
        .collection('users')
        .doc(obtainedUID.toString())
        .collection("favorites")
        .doc(widget.carID)
        .set(favouriteCar)
        .then((doc) => {})
        .whenComplete(() {
      setState(() {
        favouriteState = true;
      });
      Future.delayed(Duration(seconds: 1)).then((value) async {
        EasyLoading.showSuccess("Added to your favourite!");
        Future.delayed(Duration(seconds: 1)).then((value) async {
          EasyLoading.dismiss();
        });
      });
    });
  }

  unBookmark() async {
    await _firestore
        .collection('users')
        .doc(obtainedUID.toString())
        .collection("favorites")
        .doc(widget.carID)
        .delete()
        .whenComplete(() {
      setState(() {
        favouriteState = false;
      });
      Future.delayed(Duration(seconds: 1)).then((value) async {
        EasyLoading.showSuccess("Removed from your favourite!");
        Future.delayed(Duration(seconds: 1)).then((value) async {
          EasyLoading.dismiss();
        });
      });
    });
  }

  readFavourite() async {
    await _firestore
        .collection('users')
        .doc(obtainedUID.toString())
        .collection("favorites")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc.id == widget.carID.toString()) {
          setState(() {
            favouriteState = true;
          });
        } else if (doc.id != widget.carID.toString()) {
          setState(() {
            favouriteState = false;
          });
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
    // Icon iconFavorite = favouriteState == false
    //     ? Icon(
    //         Icons.favorite_border_outlined,
    //         color: primaryColor,
    //       )
    //     : Icon(
    //         Icons.favorite_outlined,
    //         color: favouriteColor,
    //       );

    Widget iconFavorite = favouriteState == false
        ? new IconButton(
            onPressed: () {
              bookmark();
            },
            icon: Icon(
              Icons.favorite_border_outlined,
              color: primaryColor,
            ),
          )
        : new IconButton(
            onPressed: () {
              // if (favouriteState == false) {
              //   print("it is false");
              // } else if (favouriteState == true) {
              //   print("it is true");
              // }
              unBookmark();
            },
            icon: Icon(
              Icons.favorite_outlined,
              color: favouriteColor,
            ));

    // Icon(
    //   Icons.favorite_outlined,
    //   color: favouriteColor,
    // );

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
      actions: [
        // Icon(
        //   Icons.share_outlined,
        //   color: primaryColor,
        // ),
        // SizedBox(
        //   width: 12,
        // ),
        // Icon(
        //   Icons.favorite_border_outlined,
        //   color: primaryColor,
        // ),
        iconFavorite,
        SizedBox(
          width: 20,
        ),
      ],
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
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  upperImagesContainer(),
                  SizedBox(
                    height: 10,
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
                              height: size.height * 0.018,
                            ),
                            Text(
                              'Location',
                              style: pageStyle3.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
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
                                      // Expanded(
                                      //   child: Text(
                                      //     widget.location,
                                      //     style:
                                      //         pageStyle3.copyWith(fontSize: 14),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: size.height * 0.012,
                            ),
                            // Text(
                            //   'Date',
                            //   style: pageStyle3.copyWith(
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.w900,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 4,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //           decoration: BoxDecoration(
                            //             border: Border.all(
                            //                 width: 0.5,
                            //                 color: primaryColor.withOpacity(0.4)),
                            //             borderRadius: BorderRadius.circular(5),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(vertical: 13),
                            //             child: Row(
                            //               children: [
                            //                 Expanded(
                            //                   child: Center(
                            //                     child: Text(
                            //                       'From',
                            //                       style: pageStyle3.copyWith(
                            //                         fontSize: 14,
                            //                         fontWeight: FontWeight.w900,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Expanded(
                            //                     flex: 2,
                            //                     child: Container(
                            //                       child: Center(
                            //                         child: Text(
                            //                           '28 june,\n9.00 a.m',
                            //                           style: pageStyle3.copyWith(
                            //                               fontSize: 12),
                            //                         ),
                            //                       ),
                            //                     )),
                            //               ],
                            //             ),
                            //           )),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Expanded(
                            //       child: Container(
                            //           decoration: BoxDecoration(
                            //             border: Border.all(
                            //                 width: 0.5,
                            //                 color: primaryColor.withOpacity(0.4)),
                            //             borderRadius: BorderRadius.circular(5),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(vertical: 13),
                            //             child: Row(
                            //               children: [
                            //                 Expanded(
                            //                   child: Center(
                            //                     child: Text(
                            //                       'To',
                            //                       style: pageStyle3.copyWith(
                            //                         fontSize: 14,
                            //                         fontWeight: FontWeight.w900,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Expanded(
                            //                     flex: 2,
                            //                     child: Container(
                            //                       child: Center(
                            //                         child: Text(
                            //                           '28 june,\n9.00 a.m',
                            //                           style: pageStyle3.copyWith(
                            //                               fontSize: 12),
                            //                         ),
                            //                       ),
                            //                     )),
                            //               ],
                            //             ),
                            //           )),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              'Car Description',
                              style: pageStyle3.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Year Made :',
                                        style: pageStyle3.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.yearMade,
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
                                        'Engine Capacity :',
                                        style: pageStyle3.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.engine,
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
                                        'Color :',
                                        style: pageStyle3.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.color,
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
                                        'Seat Number :',
                                        style: pageStyle3.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF2C2C2C),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        widget.seat,
                                        style: pageStyle3.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF787878),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 37),
                            Center(
                              child: Container(
                                width: 230,
                                height: 1.5,
                                color: Colors.black.withOpacity(0.20),
                              ),
                            ),
                            SizedBox(height: 26),
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
                                  left: 12.0, right: 12.0, top: 4),
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
                                      Text(
                                        widget.ownerEmail,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.60),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.ownerContact,
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
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: lowerPartDetails(),
            ),
          ),
        ],
      ),
    );
  }

  lowerPartDetails() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RM ${widget.price}',
                    style: pageStyle1,
                  ),
                  // SizedBox(
                  //   height: 3,
                  // ),
                  Text(
                    'Per Day',
                    style: pageStyle3.copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '*Insurance Included',
                    style: pageStyle3.copyWith(fontSize: 11),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed('/bookNow', arguments: widget.carID);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fourthColor.withOpacity(0.12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'Book Now',
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  upperImagesContainer() {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
            ),
            items: widget.images
                .map((imgList) => Container(
                      height: 320,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(
                          imgList,
                        ),
                        fit: BoxFit.fitWidth,
                      )),
                      // child: Image.network(imgList,fit: BoxFit.cover,),
                    ))
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(widget.images, (index, url) {
            return Container(
              width: 4.0,
              height: 4.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? primaryColor : Colors.grey[400],
              ),
            );
          }),
        ),
      ],
    );
  }
}
