import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;
String imageURL =
    "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/defaultProfilePic.jpg?alt=media&token=998c6836-ad5f-49e2-b915-c8872945acc2";
String username = "";
String email = "";
Timestamp? createdAt;
String role = "";
File? _image;
String url = "";
String _publicUID = "";

final TextEditingController nameController = TextEditingController();

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final picker = ImagePicker();
  Future getGalleryImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      print("Image Path $_image");
      EasyLoading.show(status: "Uploading...");
      saveUpdate();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        EasyLoading.showSuccess("Update Saved!");
        Future.delayed(Duration(seconds: 2)).then((value) async {
          EasyLoading.dismiss();
        });
      });
      print("Image Path $_image");
    });
  }

  // XFile? _image;
  // Future getImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //
  //   final imageTemporary = File(image.path);
  //
  //   setState(() {
  //     _image = image;
  //     print("Image Path $_image");
  //   });
  // }

  Future saveUpdate() async {
    var imageFile = FirebaseStorage.instance
        .ref()
        .child('profilePic')
        .child("$email" + "_" + "$_publicUID" + ".jpg");
    UploadTask task = imageFile.putFile(_image!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref
        .getDownloadURL()
        .whenComplete(() => EasyLoading.dismiss);

    //Create Map
    Map<String, dynamic> updateUser = {
      "createdAt": createdAt,
      "email": email,
      "profilePic": url,
      "role": role,
      "username": username
    };

    DocumentReference documentReference =
        _firestore.collection("users").doc(_publicUID.toString());

    documentReference.set(updateUser).whenComplete(
      () {
        print('$username updated');
      },
    );
  }

  Future readData() async {
    final SharedPreferences authSharedPreferences =
        await SharedPreferences.getInstance();
    final obtainedUID = authSharedPreferences.get('uidShared');
    _publicUID = obtainedUID.toString();

    //final authCurrentUser = _auth.currentUser!;
    DocumentReference documentReference =
        _firestore.collection("users").doc(obtainedUID.toString());

    await documentReference.get().then((datasnapshot) async {
      setState(() {
        username = datasnapshot.get('username');
        email = datasnapshot.get('email');
        imageURL = datasnapshot.get('profilePic');
        createdAt = datasnapshot.get('createdAt');
        role = datasnapshot.get('role');
        nameController.text = username;

        print(username);
        print(email);
        print(imageURL);
        print(createdAt!.toDate());
        print(role);
      });
    });
  }

  @override
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 21,
          ),
        ),
        //centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                    child: Stack(children: [
                      buildImage(),
                      Positioned(
                        bottom: 0,
                        right: 1,
                        //child: buildEditIcon(color),
                        child: ClipOval(
                          child: InkWell(
                            onTap: () {
                              getGalleryImage();
                              //getImage();
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              color: Colors.white,
                              child: ClipOval(
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  color: Color(0xFF7879F1),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 20),
                  buildName(email, username),
                  SizedBox(height: 20),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Hero(
                            tag: 'submit',
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(
                                    '/login/home/profile/editProfile/changePass',
                                    arguments: email);
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF647dee),
                                      Color(0xffb362f9),
                                    ]),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 10, bottom: 10),
                                  child: Container(
                                    height: 33,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Change Password',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
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
                            // ElevatedButton(
                            //   style: ButtonStyle(
                            //     shape: MaterialStateProperty.all<
                            //         RoundedRectangleBorder>(
                            //       RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //       ),
                            //     ),
                            //     backgroundColor: MaterialStateProperty.all(
                            //         Color(0xFF7879F1)),
                            //   ),
                            //   onPressed: () {
                            //     Get.toNamed(
                            //         '/login/home/profile/editProfile/changePass',
                            //         arguments: email);
                            //   },
                            //   child: Padding(
                            //     padding: EdgeInsets.all(10),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: <Widget>[
                            //         Text(
                            //           'Change Password',
                            //           style: TextStyle(
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w700,
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //         Icon(
                            //           Icons.arrow_forward,
                            //           color: Colors.white,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 50, right: 50),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         SizedBox(
                  //           height: 10.0,
                  //         ),
                  //         Hero(
                  //           tag: 'submit',
                  //           child: ElevatedButton(
                  //             onPressed: () {
                  //               Get.toNamed(
                  //                   '/login/home/profile/editProfile/changePass',
                  //                   arguments: email);
                  //             },
                  //             style: ElevatedButton.styleFrom(
                  //                 padding: EdgeInsets.zero,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(10.0))),
                  //             child: Ink(
                  //               decoration: BoxDecoration(
                  //                   gradient: LinearGradient(colors: [
                  //                     Color(0xFF647dee),
                  //                     Color(0xffb362f9),
                  //                   ]),
                  //                   borderRadius: BorderRadius.circular(10)),
                  //               child: Padding(
                  //                 padding: EdgeInsets.only(
                  //                     left: 25, right: 25, top: 10, bottom: 10),
                  //                 child: Container(
                  //                   height: 33,
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: <Widget>[
                  //                       Text(
                  //                         'Change Password',
                  //                         style: TextStyle(
                  //                           fontSize: 17,
                  //                           fontWeight: FontWeight.w700,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                       Icon(
                  //                         Icons.arrow_forward,
                  //                         color: Colors.white,
                  //                         size: 27,
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           // ElevatedButton(
                  //           //   style: ButtonStyle(
                  //           //     shape: MaterialStateProperty.all<
                  //           //         RoundedRectangleBorder>(
                  //           //       RoundedRectangleBorder(
                  //           //         borderRadius: BorderRadius.circular(10.0),
                  //           //       ),
                  //           //     ),
                  //           //     backgroundColor: MaterialStateProperty.all(
                  //           //         Color(0xFF7879F1)),
                  //           //   ),
                  //           //   onPressed: () {
                  //           //     Get.toNamed(
                  //           //         '/login/home/profile/editProfile/changePass',
                  //           //         arguments: email);
                  //           //   },
                  //           //   child: Padding(
                  //           //     padding: EdgeInsets.all(10),
                  //           //     child: Row(
                  //           //       mainAxisAlignment:
                  //           //           MainAxisAlignment.spaceBetween,
                  //           //       children: <Widget>[
                  //           //         Text(
                  //           //           'Change Password',
                  //           //           style: TextStyle(
                  //           //             fontSize: 16,
                  //           //             fontWeight: FontWeight.w700,
                  //           //             color: Colors.white,
                  //           //           ),
                  //           //         ),
                  //           //         Icon(
                  //           //           Icons.arrow_forward,
                  //           //           color: Colors.white,
                  //           //         )
                  //           //       ],
                  //           //     ),
                  //           //   ),
                  //           // ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        AuthBinding().dependencies();
                        AuthController().signOut();
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(340, 55)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 21, color: Colors.red),
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
        ),
      ),
    );
  }

  Widget buildName(String email, String username) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            username,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          const SizedBox(height: 1),
          Text(
            email,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      );

  Widget buildImage() {
    return Hero(
      tag: 'imageProfile',
      child: ClipOval(
        child: SizedBox(
          width: 120,
          height: 120,
          child: _image != null
              ? Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                )
              : Image.network(imageURL),
        ),
      ),
    );
  }
}
