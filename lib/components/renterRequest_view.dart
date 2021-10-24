import 'package:flutter/material.dart';
import 'package:p2p_car_sharing_app/models/renter_request_model.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

Widget buildRenterRequestCard(BuildContext context, int index, String uid) {
  final data = RenterRequestList.renterList[index];
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {},
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
                        //image: AssetImage(data.imagePath),
                        image: NetworkImage(data.imagePath),
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
                                      color: primaryColor.withOpacity(0.4)),
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
                            height: 14,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data.renterImage.toString(),
                                ),
                                radius: 25,
                              ),
                              SizedBox(width: 22),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.renterName.toString(),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.60),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 65),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: fourthColor.withOpacity(0.15),
                          ),
                          child: IconButton(
                            onPressed: () {},
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
