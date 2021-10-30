import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/models/admin_transaction_model.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/AdminTransDetailsPage.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

Widget buildAdminTransCard(BuildContext context, int index) {
  final data = AdminTransList.adminTransList[index];
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () async {
          Get.to(
            AdminTransDetailPage(
              transactionID: data.transactionID.toString(),
              createdAt: data.createdAt.toString(),
              paymentMethod: data.paymentMethod.toString(),
              carID: data.carID.toString(),
              ownerID: data.ownerID.toString(),
              ownerEmail: data.ownerEmail.toString(),
              ownerName: data.ownerName.toString(),
              ownerImage: data.ownerImage.toString(),
              renterID: data.renterID.toString(),
              renterEmail: data.renterEmail.toString(),
              renterName: data.renterName.toString(),
              renterImage: data.renterImage.toString(),
              totalAmount: data.totalAmount.toString(),
            ),
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 350),
          );
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15, bottom: 15, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "#" + data.transactionID,
                            style: pageStyle1,
                          ),
                          Text(
                            "Created at : " +
                                DateFormat('yyyy-MM-dd hh:MM:ss')
                                    .format(DateTime.parse(data.createdAt)),
                            style: pageStyleAdminTime,
                          ),
                          Text(
                            'Amount : RM ${data.totalAmount}',
                            style: pageStyleAdminAmount,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: fourthColor.withOpacity(0.15),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            Get.to(
                              AdminTransDetailPage(
                                transactionID: data.transactionID.toString(),
                                createdAt: data.createdAt.toString(),
                                paymentMethod: data.paymentMethod.toString(),
                                carID: data.carID.toString(),
                                ownerID: data.ownerID.toString(),
                                ownerEmail: data.ownerEmail.toString(),
                                ownerName: data.ownerName.toString(),
                                ownerImage: data.ownerImage.toString(),
                                renterID: data.renterID.toString(),
                                renterEmail: data.renterEmail.toString(),
                                renterName: data.renterName.toString(),
                                renterImage: data.renterImage.toString(),
                                totalAmount: data.totalAmount.toString(),
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
