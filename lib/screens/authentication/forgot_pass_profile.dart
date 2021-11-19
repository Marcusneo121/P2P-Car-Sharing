import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/components/rounded_button.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';

final _firestore = FirebaseFirestore.instance;
final TextEditingController resetEmailController = TextEditingController();
var email = Get.arguments;
FirebaseAuth _auth = FirebaseAuth.instance;
String _publicUID = "";

class ForgotPasswordProfile extends StatefulWidget {
  @override
  _ForgotPasswordProfileState createState() => _ForgotPasswordProfileState();
}

class _ForgotPasswordProfileState extends State<ForgotPasswordProfile> {
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
        email = datasnapshot.get('email');
        resetEmailController.text = email;
        print(email);
      });
    });
  }

  @override
  void initState() {
    readData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 14),
                    Hero(
                      tag: 'imageProfile',
                      child: Lottie.asset('assets/forgotpassword.json',
                          width: 310, height: 310),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Did someone forget their password?',
                      style: TextStyle(
                        color: Color(0xFFD6D6D6),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      "That's OK... Just enter the email address",
                      style: TextStyle(
                        color: Color(0xFFA9A7A7),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "you've used to registered with us",
                      style: TextStyle(
                        color: Color(0xFFA9A7A7),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "We'll send you a reset link!",
                      style: TextStyle(
                        color: Color(0xFF7879F1),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                            ),
                            enabled: false,
                            controller: resetEmailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              //Do something with the user input.
                              //email = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          RoundedButton(
                            title: 'Submit',
                            colour: Color(0xFF7879F1),
                            textColor: Colors.white,
                            onPressed: () async {
                              forgotPassword(resetEmailController.text);
                            },
                            tag: 'submit',
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
      ),
    );
  }

  void forgotPassword(String email) async {
    try {
      if (!email.isEmpty) {
        EasyLoading.show(
          status: "Sending Reset Email...",
        );
        await _auth.sendPasswordResetEmail(email: email);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Email Sent! Please reset your password.");
        Future.delayed(Duration(seconds: 3)).then((value) {
          EasyLoading.dismiss();
          AuthController().signOut();
          AuthBinding().dependencies();
          //Get.offNamed('/login');
        });
      } else {
        EasyLoading.dismiss();
        Get.snackbar(
          "Error Resetting Password",
          "Please ensure that email is provided.",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          isDismissible: false,
          backgroundColor: Color(0xFF7879F1),
          margin: EdgeInsets.all(20),
          animationDuration: Duration(milliseconds: 1000),
          icon: Icon(
            Icons.announcement_rounded,
            color: Colors.black,
          ),
          shouldIconPulse: false,
          overlayBlur: 4,
          overlayColor: Colors.white38,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error Resetting Password",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        isDismissible: false,
        backgroundColor: Color(0xFF7879F1),
        margin: EdgeInsets.all(20),
        animationDuration: Duration(milliseconds: 1000),
        icon: Icon(
          Icons.announcement_rounded,
          color: Colors.black,
        ),
        shouldIconPulse: false,
        overlayBlur: 4,
        overlayColor: Colors.white38,
      );
    }
  }
}
