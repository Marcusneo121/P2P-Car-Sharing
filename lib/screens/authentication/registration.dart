import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:p2p_car_sharing_app/components/rounded_button.dart';
import 'package:p2p_car_sharing_app/constant.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';

class Registration extends GetWidget<AuthController> {
  static String id = 'registration_screen';

  // @override
  // _RegistrationState createState() => _RegistrationState();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: 45.0,
              right: 45.0,
              //top: 10.0,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/carros.png'),
                    height: 80.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Create an Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    //Do something with the user input.
                    //email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                  controller: emailController,
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
                  height: 10.0,
                ),
                TextFormField(
                  //controller: ,
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    //Do something with the user input.
                    //password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                  obscureText: true,
                  controller: confirmPassController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    //Do something with the user input.
                    //email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                RoundedButton(
                  title: 'Register',
                  colour: Color(0xFF7879F1),
                  textColor: Colors.white,
                  onPressed: () async {
                    validation();
                    // setState(() {
                    //   showSpinner = true;
                    // });
                    // try {
                    //   final newUser = await _auth.createUserWithEmailAndPassword(
                    //       email: email, password: password);
                    //   if (newUser != null) {
                    //     Navigator.pushNamed(context, ChatScreen.id);
                    //   }
                    //   setState(() {
                    //     showSpinner = false;
                    //   });
                    // } catch (e) {
                    //   print(e);
                    // }
                  },
                  tag: 'loginButton',
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: SizedBox(
                    height: 2.0,
                    width: 230.0,
                    child: Container(
                      height: 2.0,
                      color: Color(0xFF2B2B2B),
                      //decoration: ,
                    ),
                  ),
                ),
                Text(
                  "Already Registered ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    //Navigator.pushNamed(context, Registration.id);
                  },
                  child: Text(
                    'Login here',
                    style: TextStyle(
                      color: Color(0xFF7879F1),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 17.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validation() {
    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty) {
      if (confirmPassController.text == passwordController.text) {
        controller.createUser(
          emailController.text,
          passwordController.text,
          usernameController.text,
        );
      } else {
        Get.snackbar(
          "Confirm Password incorrect",
          "Password and Confirm Password must be same.",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
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
    } else {
      Get.snackbar(
        "Not complete input",
        "Please ensure every field is input.",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
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

// class _RegistrationState extends State<Registration> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPassController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 45.0,
//               right: 45.0,
//               //top: 10.0,
//             ),
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Hero(
//                   tag: 'logo',
//                   child: Container(
//                     child: Image.asset('images/carros.png'),
//                     height: 80.0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Text(
//                   'Create an Account',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 TextFormField(
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Poppins',
//                     fontSize: 20.0,
//                   ),
//                   controller: usernameController,
//                   keyboardType: TextInputType.name,
//                   textAlign: TextAlign.left,
//                   onChanged: (value) {
//                     //Do something with the user input.
//                     //email = value;
//                   },
//                   decoration: kTextFieldDecoration.copyWith(
//                     hintText: 'Username',
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'Poppins',
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 TextFormField(
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Poppins',
//                     fontSize: 20.0,
//                   ),
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   textAlign: TextAlign.left,
//                   onChanged: (value) {
//                     //Do something with the user input.
//                     //email = value;
//                   },
//                   decoration: kTextFieldDecoration.copyWith(
//                     hintText: 'Email',
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'Poppins',
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 TextFormField(
//                   //controller: ,
//                   obscureText: true,
//                   controller: passwordController,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Poppins',
//                     fontSize: 20.0,
//                   ),
//                   textAlign: TextAlign.left,
//                   onChanged: (value) {
//                     //Do something with the user input.
//                     //password = value;
//                   },
//                   decoration: kTextFieldDecoration.copyWith(
//                     hintText: 'Password',
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'Poppins',
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 TextFormField(
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Poppins',
//                     fontSize: 20.0,
//                   ),
//                   obscureText: true,
//                   controller: confirmPassController,
//                   keyboardType: TextInputType.emailAddress,
//                   textAlign: TextAlign.left,
//                   onChanged: (value) {
//                     //Do something with the user input.
//                     //email = value;
//                   },
//                   decoration: kTextFieldDecoration.copyWith(
//                     hintText: 'Confirm Password',
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'Poppins',
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 RoundedButton(
//                   title: 'Register',
//                   colour: Color(0xFF7879F1),
//                   textColor: Colors.white,
//                   onPressed: () async {
//                     // setState(() {
//                     //   showSpinner = true;
//                     // });
//                     // try {
//                     //   final newUser = await _auth.createUserWithEmailAndPassword(
//                     //       email: email, password: password);
//                     //   if (newUser != null) {
//                     //     Navigator.pushNamed(context, ChatScreen.id);
//                     //   }
//                     //   setState(() {
//                     //     showSpinner = false;
//                     //   });
//                     // } catch (e) {
//                     //   print(e);
//                     // }
//                   },
//                   tag: 'loginButton',
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 30, bottom: 20),
//                   child: SizedBox(
//                     height: 2.0,
//                     width: 230.0,
//                     child: Container(
//                       height: 2.0,
//                       color: Color(0xFF2B2B2B),
//                       //decoration: ,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "Already Registered ?",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.back();
//                     //Navigator.pushNamed(context, Registration.id);
//                   },
//                   child: Text(
//                     'Login here',
//                     style: TextStyle(
//                       color: Color(0xFF7879F1),
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins',
//                       fontSize: 17.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
