import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

String obtainedUID = "";

class AdminHome extends StatefulWidget {
  static String id = 'adminHome_screen';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new WillPopScope(
      onWillPop: () async {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     duration: Duration(milliseconds: 800),
        //     content: Text(
        //       'Logout Instead.',
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontFamily: 'Poppins',
        //         fontWeight: FontWeight.w600,
        //       ),
        //     )));
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 22.0,
              right: 22.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 11.0,
                        ),
                        Image.asset(
                          'assets/adminLogo.png',
                          width: size.width - 300,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 4.0,
                        ),
                        NeumorphicButton(
                          onPressed: () {
                            Get.toNamed('/adminProfile');
                          },
                          style: NeumorphicStyle(
                            color: Color(0xFFE9E9E9),
                            lightSource: LightSource.topLeft,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: 7,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.settings_rounded,
                            size: 27.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        NeumorphicButton(
                          onPressed: () {
                            AuthBinding().dependencies();
                            AuthController().signOut();
                          },
                          style: NeumorphicStyle(
                            color: Color(0xFFE9E9E9),
                            lightSource: LightSource.topLeft,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: 7,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.logout_rounded,
                            size: 27,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/adminCars');
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0))),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF647dee),
                            Color(0xffb362f9),
                          ]),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 17, right: 25, top: 10, bottom: 10),
                          child: Container(
                            height: 170,
                            width: size.width - 114,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_car_outlined,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Cars',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                //SizedBox(height: 10),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       color: Colors.white,
                                //       size: 27,
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/adminTransaction');
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0))),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF647dee),
                            Color(0xffb362f9),
                          ]),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 17, right: 25, top: 10, bottom: 10),
                          child: Container(
                            height: 170,
                            width: size.width - 114,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long_rounded,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Transactions',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                //SizedBox(height: 10),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       color: Colors.white,
                                //       size: 27,
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/adminUsers');
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0))),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF647dee),
                            Color(0xffb362f9),
                          ]),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 17, right: 25, top: 10, bottom: 10),
                          child: Container(
                            height: 170,
                            width: size.width - 114,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Users',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                //SizedBox(height: 10),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Icon(
                                //       Icons.arrow_forward,
                                //       color: Colors.white,
                                //       size: 27,
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    uidShared();
  }

  Future<void> uidShared() async {
    final SharedPreferences stayLoginShared =
        await SharedPreferences.getInstance();
    setState(() {
      obtainedUID = stayLoginShared.get('uidShared').toString();
    });
  }
}
