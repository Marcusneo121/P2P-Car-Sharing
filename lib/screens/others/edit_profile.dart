import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;
String imageURL =
    "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/defaultProfilePic.jpg?alt=media&token=998c6836-ad5f-49e2-b915-c8872945acc2";
String username = "";
String email = "";

final TextEditingController nameController = TextEditingController();

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final picker = ImagePicker();
  Future getGalleryImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
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

  void saveUpdate() {}

  Future readData() async {
    final SharedPreferences authSharedPreferences =
        await SharedPreferences.getInstance();
    final obtainedUID = authSharedPreferences.get('uidShared');

    //final authCurrentUser = _auth.currentUser!;
    DocumentReference documentReference =
        _firestore.collection("users").doc(obtainedUID.toString());

    await documentReference.get().then((datasnapshot) async {
      setState(() {
        username = datasnapshot.get('username');
        email = datasnapshot.get('email');
        imageURL = datasnapshot.get('profilePic');
        nameController.text = username;
      });
    });
  }

  @override
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Edit Profile',
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
                                  color: color,
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
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     'Username',
                          //     style: TextStyle(
                          //       fontSize: 17,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          // TextFormField(
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontFamily: 'Poppins',
                          //     fontSize: 17.0,
                          //   ),
                          //   controller: nameController,
                          //   keyboardType: TextInputType.emailAddress,
                          //   textAlign: TextAlign.left,
                          //   onChanged: (value) {
                          //     //Do something with the user input.
                          //     //email = value;
                          //   },
                          //   decoration: kTextFieldDecoration.copyWith(
                          //     hintText: 'Username',
                          //     hintStyle: TextStyle(
                          //       color: Colors.grey,
                          //       fontFamily: 'Poppins',
                          //       fontSize: 17.0,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Hero(
                            tag: 'submit',
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF7879F1)),
                              ),
                              onPressed: () {
                                Get.toNamed(
                                    '/login/home/profile/editProfile/changePass',
                                    arguments: email);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Change Password',
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
                          ),
                          // Material(
                          //   elevation: 5.0,
                          //   color: Color(0xFF7879F1),
                          //   borderRadius: BorderRadius.circular(10.0),
                          //   child: MaterialButton(
                          //     onPressed: () {},
                          //     minWidth: 400.0,
                          //     height: 50.0,
                          //     child: Text(
                          //       'Change Password',
                          //       textAlign: TextAlign.left,
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 17.0,
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: 'Poppins',
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        saveUpdate();
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(340, 55)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side:
                                BorderSide(color: Color(0xFF7879F1), width: 2),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor: MaterialStateProperty.all(Colors.white12),
                      ),
                      child: Text(
                        "Save",
                        style:
                            TextStyle(fontSize: 21, color: Color(0xFF7879F1)),
                      ),
                    ),
                    // RoundedButton(
                    //   title: 'Save',
                    //   colour: Color(0xFF7879F1),
                    //   textColor: Colors.white,
                    //   onPressed: () async {},
                    //   tag: 'saveButton',
                    // ),
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
