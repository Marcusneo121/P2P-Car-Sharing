import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/controllers/launcherController.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/adminTransactions.dart';
import '../../../constant.dart';

class AdminUsersDetailPage extends StatefulWidget {
  final String userID, createdAt, email, profilePic, role, username;

  const AdminUsersDetailPage({
    Key? key,
    required this.userID,
    required this.createdAt,
    required this.email,
    required this.profilePic,
    required this.role,
    required this.username,
  }) : super(key: key);

  @override
  _AdminUsersDetailPageState createState() => _AdminUsersDetailPageState();
}

class _AdminUsersDetailPageState extends State<AdminUsersDetailPage> {
  int _currentIndex = 0;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    setState(() {
      //uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color(0xffd0d0d0),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Color(0xffd0d0d0),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          onPressed: () {
            Get.back();
          },
          style: NeumorphicStyle(
            color: Color(0xffd0d0d0),
            shadowLightColor: Color(0xFFFFFFFF),
            lightSource: LightSource.topLeft,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 4,
          ),
          padding: const EdgeInsets.only(
              left: 12.0, right: 5.0, bottom: 12.0, top: 10.0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
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
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 23),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.profilePic.toString(),
                    ),
                    radius: 77,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.username,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 1),
                  GestureDetector(
                    child: Text(
                      widget.email,
                      style: TextStyle(
                        color: Color(0xff7575ff),
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () => LaunchUtils.openEmail(
                        toEmail: widget.email, subject: "Carro Admin Contact"),
                  ),
                  SizedBox(height: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "User's Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(bottom: 2),
                        child: SizedBox(
                          height: 1.4,
                          width: 242.0,
                          child: Container(
                            height: 1.4,
                            color: Colors.black.withOpacity(0.3),
                            //decoration: ,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User ID : ",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            widget.userID,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Joined At : ",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd hh:MM:ss a')
                                .format(DateTime.parse(widget.createdAt)),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Role : ",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            widget.role,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 66.0, right: 66.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showDialog();
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(340, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  deleteUser() async {
    await _firestore
        .collection('users')
        .doc(widget.userID.toString())
        .delete()
        .whenComplete(() async {
      Future.delayed(Duration(seconds: 1)).then((value) async {
        EasyLoading.showSuccess("User deleted!");
        Future.delayed(Duration(seconds: 2)).then((value) async {
          EasyLoading.dismiss();
          Get.offNamed('/login/adminHome');
        });
      });
    });
  }

  _showDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.only(left: 25, top: 15, right: 10, bottom: 5),
          elevation: 10.0,
          backgroundColor: Color(0xFFcfdaff),
          title: Text('Are you sure?'),
          content: Text(
            'You will not be able to recover once deleted. This process cannot be undone.',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: Color(0xFF6c6deb), fontSize: 17),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Color(0xFF6c6deb), fontSize: 17),
              ),
              onPressed: () {
                deleteUser();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
