import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/screens/adminHome.dart';
import 'package:p2p_car_sharing_app/screens/authentication/forgot_pass.dart';
import 'package:p2p_car_sharing_app/screens/authentication/forgot_pass_profile.dart';
import 'package:p2p_car_sharing_app/screens/home.dart';
import 'package:p2p_car_sharing_app/screens/authentication/registration.dart';
import 'package:p2p_car_sharing_app/screens/others/edit_profile.dart';
import 'package:p2p_car_sharing_app/screens/splashscreen.dart';
import 'screens/authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialBinding: AuthBinding(),
      builder: EasyLoading.init(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      //defaultTransition: Transition.cupertino,
      getPages: [
        GetPage(name: '/', page: () => Splashscreen()),
        GetPage(
          name: '/login',
          page: () => Login(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 800),
        ),
        GetPage(name: '/login/registration', page: () => Registration()),
        GetPage(name: '/login/forgotPass', page: () => ForgotPassword()),
        GetPage(
          name: '/login/home',
          page: () => Home(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: '/login/home/profile/editProfile',
          page: () => EditProfile(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/login/home/profile/editProfile/changePass',
          page: () => ForgotPasswordProfile(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/login/adminHome',
          page: () => AdminHome(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 600),
        ),
        // GetPage(
        //   name: '/nextScreen',
        //   page: () => NextScreen(),
        //   transition: Transition.zoom,
        // ),
      ],
      // home: Splashscreen(),
      // initialRoute: Splashscreen.id,
      // routes: {
      //   Splashscreen.id: (context) => Splashscreen(),
      //   Login.id: (context) => Login(),
      //   Registration.id: (context) => Registration(),
      //   Home.id: (context) => Home(),
      // },
    );
  }
}
