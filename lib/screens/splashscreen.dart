import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
Rxn<User> _firebaseUser = Rxn<User>();

class Splashscreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    getStayLogin();
  }

  Future getStayLogin() async {
    final SharedPreferences stayLoginShared =
        await SharedPreferences.getInstance();
    final obtainedEmail = stayLoginShared.get('emailShared');
    final obtainedPassword = stayLoginShared.get('passwordShared');
    // setState(() {
    //   finalEmail = obtainedEmail;
    //   finalPassword = obtainedPassword;
    // });
    if (obtainedEmail == null && obtainedPassword == null) {
      Future.delayed(Duration(seconds: 4)).then((value) {
        Get.offNamed('/login');
      });
    } else {
      // await _auth.signInWithEmailAndPassword(
      //     email: obtainedEmail.toString(),
      //     password: obtainedPassword.toString());
      // Future.delayed(Duration(milliseconds: 800)).then((value) {
      //   Get.offNamed('/login/home');
      // });
      AuthController()
          .login(obtainedEmail.toString(), obtainedPassword.toString());
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Obx(() {
          //   return (Get.find<AuthController>().user != null) ? Home() : Login();
          // }),
          Spacer(),
          Hero(
            tag: 'logo',
            child: Container(
              width: 400,
              height: 100,
              child: Image.asset('images/carros.png'),
            ),
          ),
          //SizedBox(height: 32),
          // Text(
          //   'Car for everyone.',
          //   style: TextStyle(
          //     color: Color(0xFF7879F1),
          //     fontFamily: 'Poppins',
          //     fontSize: 20,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          Spacer(),
        ],
      ),
    );
  }
}
