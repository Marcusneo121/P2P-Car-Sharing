import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_car_sharing_app/models/car_model.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/car_details_page.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

Widget buildCarCard(BuildContext context, int index) {
  final data = CarList.list[index];
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            CarDetailPage(
              images: data.images,
              carName: data.carName,
              carPlate: data.carPlate,
              price: data.price,
            ),
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 500),
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
                        image: AssetImage(data.imagePath),
                        height: 130,
                      ),
                    )),
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
                          Text(
                            data.carName,
                            style: pageStyle1,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: primaryColor.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      data.carPlate,
                                      style: pageStyle2,
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'RM ${data.price}',
                                style: pageStyle3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: fourthColor.withOpacity(0.15),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(
                              CarDetailPage(
                                images: data.images,
                                carName: data.carName,
                                carPlate: data.carPlate,
                                price: data.price,
                              ),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: fourthColor,
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
