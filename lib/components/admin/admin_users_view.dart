import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/models/admin/admin_users_model.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/AdminUsersDetails.dart';
import '../../constant.dart';

Widget buildAdminUsersCard(BuildContext context, int index) {
  final data = AdminUsersList.adminUsersList[index];
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
            AdminUsersDetailPage(
              createdAt: data.createdAt.toString(),
              role: data.role.toString(),
              userID: data.userID.toString(),
              profilePic: data.profilePic.toString(),
              email: data.email.toString(),
              username: data.username.toString(),
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
                            data.username,
                            style: pageStyle1,
                          ),
                          Text(
                            "Joined on : " +
                                DateFormat('yyyy-MM-dd hh:MM:ss')
                                    .format(DateTime.parse(data.createdAt)),
                            style: pageStyleAdminTime,
                          ),
                          Text(
                            'Email : ${data.email}',
                            style: pageStyleAdminID,
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
                              AdminUsersDetailPage(
                                createdAt: data.createdAt.toString(),
                                role: data.role.toString(),
                                userID: data.userID.toString(),
                                profilePic: data.profilePic.toString(),
                                email: data.email.toString(),
                                username: data.username.toString(),
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
