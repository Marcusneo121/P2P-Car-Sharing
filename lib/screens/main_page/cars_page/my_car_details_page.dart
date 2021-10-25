import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class MyCarDetailPage extends StatefulWidget {
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

  const MyCarDetailPage(
      {Key? key,
      required this.images,
      required this.carID,
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
  _MyCarDetailPageState createState() => _MyCarDetailPageState();
}

class _MyCarDetailPageState extends State<MyCarDetailPage> {
  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color(0xffe3e3e3),
      body: getBody(),
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
                                    width: 0.5,
                                    color: primaryColor.withOpacity(0.4)),
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
                            height: size.height * 0.012,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: lowerPartDetails(),
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
                    '/Per Day',
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
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed('/editCar', arguments: widget.carID);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fourthColor.withOpacity(0.12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      '   Edit   ',
                      style: pageStyle3.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: tertiaryColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: fifthColor.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      ' Delete ',
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
        SizedBox(height: 20),
      ],
    );
  }

  upperImagesContainer() {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
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
              autoPlayInterval: const Duration(seconds: 2),
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
