import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/components/profile_widget.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:p2p_car_sharing_app/models/user.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/adminHome.dart';
import 'package:p2p_car_sharing_app/screens/others/edit_profile.dart';
import 'package:p2p_car_sharing_app/utils/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;
String imageURL =
    "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/defaultProfilePic.jpg?alt=media&token=998c6836-ad5f-49e2-b915-c8872945acc2";
String username = "";
String email = "";
String argumentUID = "";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = UserPreferences.myUser;

  @override
  void initState() {
    readData();
  }

  Future readData() async {
    final SharedPreferences authSharedPreferences =
        await SharedPreferences.getInstance();
    final obtainedUID = authSharedPreferences.get('uidShared');
    argumentUID = obtainedUID.toString();
    print(argumentUID);
    //final authCurrentUser = _auth.currentUser!;
    DocumentReference documentReference =
        _firestore.collection("users").doc(obtainedUID.toString());

    await documentReference.get().then((datasnapshot) async {
      setState(() {
        username = datasnapshot.get('username');
        email = datasnapshot.get('email');
        imageURL = datasnapshot.get('profilePic');

        print(username);
        print(email);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 25.0,
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 15, top: 10, bottom: 10),
                  height: height * 0.196,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(colors: [
                      Color(0xFF647dee),
                      Color(0xffb362f9),
                      //Color(0xFF7879F1)
                    ]),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ProfileWidget(
                        imagePath: imageURL,
                        onClicked: () async {
                          Get.toNamed('/login/home/profile/editProfile');
                        },
                      ),
                      const SizedBox(width: 15),
                      buildName(email, username)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3, right: 3),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 13),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/login/home/profile/myCar',
                              arguments: argumentUID);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF647dee),
                                Color(0xffb362f9),
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 17, right: 25, top: 10, bottom: 10),
                            child: Container(
                              height: 33,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        'My Car',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 27,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 13),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/login/home/profile/myCar/addCar');
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF647dee),
                                Color(0xffb362f9),
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 17, right: 25, top: 10, bottom: 10),
                            child: Container(
                              height: 33,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        'Add Car',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 27,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 13),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/help');
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF647dee),
                                Color(0xffb362f9),
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 17, right: 25, top: 10, bottom: 10),
                            child: Container(
                              height: 33,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.help_outline_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        'Help',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 27,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 13),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Get.toNamed('/myTrans');
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.zero,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10.0))),
                      //   child: Ink(
                      //     decoration: BoxDecoration(
                      //         gradient: LinearGradient(colors: [
                      //           Color(0xFF647dee),
                      //           Color(0xffb362f9),
                      //           //Color(0xFF7879F1)
                      //         ]),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 25, right: 25, top: 10, bottom: 10),
                      //       child: Container(
                      //         height: 33,
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: <Widget>[
                      //             Text(
                      //               'My Transactions',
                      //               style: TextStyle(
                      //                 fontSize: 17,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             Icon(
                      //               Icons.arrow_forward,
                      //               color: Colors.white,
                      //               size: 27,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 13),
                      ElevatedButton(
                        onPressed: () {
                          print('Hi there');
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF647dee),
                                Color(0xffb362f9),
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 17, right: 25, top: 10, bottom: 10),
                            child: Container(
                              height: 33,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        'About the app',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 27,
                                  )
                                ],
                              ),
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
    );
  }

  Widget buildName(String email, String username) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            username,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 1),
          Text(
            email,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          )
        ],
      );
}
