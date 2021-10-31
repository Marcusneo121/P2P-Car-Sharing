import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  Future<void> onInit() async {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }
  // //GET UID
  // Future<String> getCurrentUID() async {
  //   return (await _auth.currentUser!).uid;
  // }

  void createUser(String email, String password, String username) async {
    try {
      EasyLoading.show(
        status: "Creating Account...",
      );
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user!.sendEmailVerification();
      final uid = (_auth.currentUser!).uid;
      DocumentReference documentReference =
          _firestore.collection('users').doc(uid.toString());

      //Create Map
      Map<String, dynamic> userDetails = {
        "username": username,
        "email": email,
        "createdAt": DateTime.now(),
        "role": "normal",
        "profilePic":
            "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/defaultProfilePic.jpg?alt=media&token=998c6836-ad5f-49e2-b915-c8872945acc2",
      };

      documentReference.set(userDetails).whenComplete(
        () async {
          await EasyLoading.dismiss();
          EasyLoading.showSuccess(
              "Account Created! Verify account before login.");
          Future.delayed(Duration(seconds: 3)).then((value) {
            EasyLoading.dismiss();
            Get.back();
          });
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error Creating account.",
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
          Get.offNamed('/login');
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

  void login(String email, String password) async {
    try {
      EasyLoading.show(
        status: "Logging in...",
      );
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final authCurrentUser = _auth.currentUser!;
      final SharedPreferences authSharedPreferences =
          await SharedPreferences.getInstance();
      if (authCurrentUser.emailVerified) {
        //user!.emailVerified
        DocumentReference documentReference =
            _firestore.collection("users").doc(authCurrentUser.uid);
        documentReference.get().then((datasnapshot) async {
          if (datasnapshot.get('role') == 'admin') {
            authSharedPreferences.setString('emailShared', email);
            authSharedPreferences.setString('passwordShared', password);
            authSharedPreferences.setString(
                'uidShared', authCurrentUser.uid.toString());
            EasyLoading.dismiss();
            Get.offNamed('/login/adminHome');
          } else {
            authSharedPreferences.setString('emailShared', email);
            authSharedPreferences.setString('passwordShared', password);
            authSharedPreferences.setString(
                'uidShared', authCurrentUser.uid.toString());
            EasyLoading.dismiss();
            Get.offNamed('/login/home');
          }
        });
      } else {
        EasyLoading.dismiss();
        Get.snackbar(
          "Error Login In.",
          "Please verify your email and try again.",
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
      if (email.isEmpty && password.isEmpty) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Error Login In.",
          "Please ensure field is not empty.",
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
      } else {
        EasyLoading.dismiss();
        Get.snackbar(
          "Error Login In.",
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

  void signOut() async {
    try {
      EasyLoading.show(status: "Logging out...");
      await _auth.signOut();
      print("Sign out");
      Future.delayed(Duration(seconds: 1)).then((value) async {
        final SharedPreferences authShared =
            await SharedPreferences.getInstance();
        authShared.clear();
        EasyLoading.dismiss();
        Get.offAllNamed('/');
      });
    } catch (e) {
      Get.snackbar(
        "Error Signing Out.",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
