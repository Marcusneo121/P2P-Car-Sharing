import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/components/profile_widget.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:p2p_car_sharing_app/models/user.dart';
import 'package:p2p_car_sharing_app/screens/adminHome.dart';
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
                  padding: EdgeInsets.only(left: 6, right: 6),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF7477F0)),
                        ),
                        onPressed: () {
                          //To Press for action
                          Get.toNamed('/login/home/profile/myCar',
                              arguments: argumentUID);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'My Car',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF7477F0)),
                        ),
                        onPressed: () {
                          //To Press for action
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Others',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   children: <Widget>[
                //     ElevatedButton(
                //       onPressed: () {
                //         setState(() {
                //           username = "";
                //           email = "";
                //           imageURL =
                //               "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/defaultProfilePic.jpg?alt=media&token=998c6836-ad5f-49e2-b915-c8872945acc2";
                //         });
                //         AuthBinding().dependencies();
                //         AuthController().signOut();
                //       },
                //       style: ButtonStyle(
                //         fixedSize: MaterialStateProperty.all(Size(340, 55)),
                //         shape: MaterialStateProperty.all(
                //           RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //             side: BorderSide(color: Colors.red, width: 2),
                //           ),
                //         ),
                //         backgroundColor:
                //             MaterialStateProperty.all(Colors.transparent),
                //         shadowColor:
                //             MaterialStateProperty.all(Colors.transparent),
                //       ),
                //       child: Text(
                //         "Logout",
                //         style: TextStyle(fontSize: 21, color: Colors.red),
                //       ),
                //     ),
                //     SizedBox(height: 18),
                //   ],
                // ),
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

  // Widget buildName(UserProfile user) => Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           user.name,
  //           style: TextStyle(
  //               fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
  //         ),
  //         const SizedBox(height: 1),
  //         Text(
  //           user.email,
  //           style: TextStyle(color: Colors.white70, fontSize: 15),
  //         )
  //       ],
  //     );
}
