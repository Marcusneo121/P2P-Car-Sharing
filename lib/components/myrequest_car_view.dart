import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:p2p_car_sharing_app/models/my_request_model.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/my_request_detail_page.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

Widget buildMyRequestCard(BuildContext context, int index, String uid) {
  final data = MyRequestList.myRequestList[index];
  Widget status = data.status == "Requesting"
      ? new Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: Color(0xff0ab31d)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              data.status,
              style: TextStyle(
                color: Color(0xff0ab31d).withOpacity(0.8),
                fontSize: 11,
                letterSpacing: 2.6,
                wordSpacing: 1,
              ),
            ),
          ),
        )
      : new Container(
          decoration: BoxDecoration(
            border:
                Border.all(width: 0.5, color: primaryColor.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              data.status,
              style: pageStyle2,
            ),
          ),
        );
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            MyRequestDetailPage(
              imagePath: data.imagePath,
              carID: data.carID,
              carName: data.carName,
              carPlate: data.carPlate,
              price: data.price,
              originalPrice: data.originalPrice,
              location: data.location,
              toDate: data.toDate,
              fromDate: data.fromDate,
              ownerID: data.ownerID,
              ownerEmail: data.ownerEmail,
              ownerName: data.ownerName,
              ownerImage: data.ownerImage,
              status: data.status,
            ),
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 350),
          );
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Image(
                      image: NetworkImage(data.imagePath),
                      height: 130,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                data.carName,
                                style: pageStyle1,
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color: primaryColor.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    data.carPlate,
                                    style: pageStyle2,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Center(
                            child: Container(
                              width: size.width - 165,
                              height: 1.5,
                              color: Colors.black.withOpacity(0.20),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data.ownerImage.toString(),
                                ),
                                radius: 25,
                              ),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.ownerName.toString(),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.60),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  status,
                                  // Text(
                                  //   data.renterName.toString(),
                                  //   style: TextStyle(
                                  //       color: Colors.black.withOpacity(0.60),
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 85, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: fourthColor.withOpacity(0.15),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.to(
                                MyRequestDetailPage(
                                  imagePath: data.imagePath,
                                  carID: data.carID,
                                  carName: data.carName,
                                  carPlate: data.carPlate,
                                  price: data.price,
                                  originalPrice: data.originalPrice,
                                  location: data.location,
                                  toDate: data.toDate,
                                  fromDate: data.fromDate,
                                  ownerID: data.ownerID,
                                  ownerEmail: data.ownerEmail,
                                  ownerName: data.ownerName,
                                  ownerImage: data.ownerImage,
                                  status: data.status,
                                ),
                                transition: Transition.cupertino,
                                duration: Duration(milliseconds: 350),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: fourthColor,
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
        ),
      ),
    ),
  );
}
