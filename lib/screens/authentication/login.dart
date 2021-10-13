import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:p2p_car_sharing_app/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:p2p_car_sharing_app/constant.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:p2p_car_sharing_app/screens/home.dart';
import 'package:p2p_car_sharing_app/screens/authentication/registration.dart';

class Login extends GetWidget<AuthController> {
  static String id = 'login_screen';

  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: 38.0,
                right: 38.0,
                top: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110.0,
                      ),
                      Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset('images/carros.png'),
                          height: 110.0,
                        ),
                      ),
                      // SizedBox(
                      //   child: DefaultTextStyle(
                      //     style: const TextStyle(
                      //       fontSize: 18.0,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w400,
                      //       fontFamily: 'Poppins',
                      //     ),
                      //     child: AnimatedTextKit(
                      //       animatedTexts: [
                      //         // TypewriterAnimatedText(
                      //         //   '   P2P',
                      //         //   speed: const Duration(milliseconds: 100),
                      //         // ),
                      //         TypewriterAnimatedText(
                      //           '     P2P Car-Sharing',
                      //           speed: const Duration(milliseconds: 100),
                      //         ),
                      //         TypewriterAnimatedText(
                      //           '     Earn Extra Money',
                      //           speed: const Duration(milliseconds: 60),
                      //         ),
                      //         TypewriterAnimatedText(
                      //           '     The more you rent',
                      //           speed: const Duration(milliseconds: 60),
                      //         ),
                      //         TypewriterAnimatedText(
                      //           '     The more you earn',
                      //           speed: const Duration(milliseconds: 60),
                      //         ),
                      //       ],
                      //       repeatForever: true,
                      //       pause: const Duration(milliseconds: 300),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
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
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/login/forgotPass');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  RoundedButton(
                    title: 'Login',
                    colour: Color(0xFF7879F1),
                    textColor: Colors.white,
                    onPressed: () async {
                      controller.login(
                          emailController.text, passwordController.text);

                      //Get.offAllNamed('/login/home');
                      //Navigator.pushNamed(context, Home.id);
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
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login/registration');
                      //Navigator.pushNamed(context, Registration.id);
                    },
                    child: Text(
                      'Register here',
                      style: TextStyle(
                        color: Color(0xFF7879F1),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//
//     animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
//         .animate(controller);
//
//     controller.forward();
//
//     controller.addListener(() {
//       setState(() {});
//       print(animation.value);
//     });
//
//     void dispose() {
//       controller.dispose();
//       super.dispose();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController passwordController = TextEditingController();
//     final TextEditingController emailController = TextEditingController();
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 45.0,
//                 right: 45.0,
//                 top: 20.0,
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 110.0,
//                       ),
//                       Hero(
//                         tag: 'logo',
//                         child: Container(
//                           child: Image.asset('images/carros.png'),
//                           height: 110.0,
//                         ),
//                       ),
//                       SizedBox(
//                         child: DefaultTextStyle(
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Poppins',
//                           ),
//                           child: AnimatedTextKit(
//                             animatedTexts: [
//                               // TypewriterAnimatedText(
//                               //   '   P2P',
//                               //   speed: const Duration(milliseconds: 100),
//                               // ),
//                               TypewriterAnimatedText(
//                                 '     P2P Car-Sharing',
//                                 speed: const Duration(milliseconds: 100),
//                               ),
//                               TypewriterAnimatedText(
//                                 '     Earn Extra Money',
//                                 speed: const Duration(milliseconds: 60),
//                               ),
//                               TypewriterAnimatedText(
//                                 '     The more you rent',
//                                 speed: const Duration(milliseconds: 60),
//                               ),
//                               TypewriterAnimatedText(
//                                 '     The more you earn',
//                                 speed: const Duration(milliseconds: 60),
//                               ),
//                             ],
//                             repeatForever: true,
//                             pause: const Duration(milliseconds: 300),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50.0,
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: <Widget>[
//                       TextFormField(
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Poppins',
//                           fontSize: 20.0,
//                         ),
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         textAlign: TextAlign.left,
//                         onChanged: (value) {
//                           //Do something with the user input.
//                           //email = value;
//                         },
//                         decoration: kTextFieldDecoration.copyWith(
//                           hintText: 'Email',
//                           hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontFamily: 'Poppins',
//                             fontSize: 20.0,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       TextFormField(
//                         //controller: ,
//                         obscureText: true,
//                         controller: passwordController,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Poppins',
//                           fontSize: 20.0,
//                         ),
//                         textAlign: TextAlign.left,
//                         onChanged: (value) {
//                           //Do something with the user input.
//                           //password = value;
//                         },
//                         decoration: kTextFieldDecoration.copyWith(
//                           hintText: 'Password',
//                           hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontFamily: 'Poppins',
//                             fontSize: 20.0,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Get.toNamed('/login/forgotPass');
//                         },
//                         child: Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Poppins',
//                             fontSize: 16.0,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   RoundedButton(
//                     title: 'Login',
//                     colour: Color(0xFF7879F1),
//                     textColor: Colors.white,
//                     onPressed: () async {
//                       FocusScope.of(context).unfocus();
//                       Get.offAllNamed('/login/home');
//                       //Navigator.pushNamed(context, Home.id);
//                       // setState(() {
//                       //   showSpinner = true;
//                       // });
//                       // try {
//                       //   final newUser = await _auth.createUserWithEmailAndPassword(
//                       //       email: email, password: password);
//                       //   if (newUser != null) {
//                       //     Navigator.pushNamed(context, ChatScreen.id);
//                       //   }
//                       //   setState(() {
//                       //     showSpinner = false;
//                       //   });
//                       // } catch (e) {
//                       //   print(e);
//                       // }
//                     },
//                     tag: 'loginButton',
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 30, bottom: 20),
//                     child: SizedBox(
//                       height: 2.0,
//                       width: 230.0,
//                       child: Container(
//                         height: 2.0,
//                         color: Color(0xFF2B2B2B),
//                         //decoration: ,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "Don't have an account?",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins',
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Get.toNamed('/login/registration');
//                       //Navigator.pushNamed(context, Registration.id);
//                     },
//                     child: Text(
//                       'Register here',
//                       style: TextStyle(
//                         color: Color(0xFF7879F1),
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Poppins',
//                         fontSize: 17.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
