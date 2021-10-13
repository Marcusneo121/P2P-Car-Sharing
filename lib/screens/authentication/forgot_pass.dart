import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/rounded_button.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';

import '../../constant.dart';

class ForgotPassword extends GetWidget<AuthController> {
  // @override
  // _ForgotPasswordState createState() => _ForgotPasswordState();

  final TextEditingController resetEmailController = TextEditingController();

  @override
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
                      tag: 'logo',
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
                              fontSize: 20.0,
                            ),
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
                              controller
                                  .forgotPassword(resetEmailController.text);
                            },
                            tag: 'loginButton',
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
}

// class _ForgotPasswordState extends State<ForgotPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Forgot Password',
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.only(left: 30, right: 30),
//               child: Container(
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(height: 14),
//                     Hero(
//                       tag: 'logo',
//                       child: Lottie.asset('assets/forgotpassword.json',
//                           width: 310, height: 310),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Did someone forget their password?',
//                       style: TextStyle(
//                         color: Color(0xFFD6D6D6),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     SizedBox(height: 18),
//                     Text(
//                       "That's OK... Just enter the email address",
//                       style: TextStyle(
//                         color: Color(0xFFA9A7A7),
//                         fontSize: 15,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     Text(
//                       "you've used to registered with us",
//                       style: TextStyle(
//                         color: Color(0xFFA9A7A7),
//                         fontSize: 15,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "We'll send you a reset link!",
//                       style: TextStyle(
//                         color: Color(0xFF7879F1),
//                         fontSize: 19,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: Column(
//                         children: <Widget>[
//                           TextField(
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Poppins',
//                               fontSize: 20.0,
//                             ),
//                             keyboardType: TextInputType.emailAddress,
//                             textAlign: TextAlign.left,
//                             onChanged: (value) {
//                               //Do something with the user input.
//                               //email = value;
//                             },
//                             decoration: kTextFieldDecoration.copyWith(
//                               hintText: 'Email',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'Poppins',
//                                 fontSize: 20.0,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15.0,
//                           ),
//                           RoundedButton(
//                             title: 'Submit',
//                             colour: Color(0xFF7879F1),
//                             textColor: Colors.white,
//                             onPressed: () async {},
//                             tag: 'loginButton',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
