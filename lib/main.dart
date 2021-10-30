import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/adminHome.dart';
import 'package:p2p_car_sharing_app/screens/authentication/forgot_pass.dart';
import 'package:p2p_car_sharing_app/screens/authentication/forgot_pass_profile.dart';
import 'package:p2p_car_sharing_app/screens/home.dart';
import 'package:p2p_car_sharing_app/screens/authentication/registration.dart';
import 'package:p2p_car_sharing_app/screens/main_page/RenterRequest.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/admin_profile.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/addCar.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/book_car.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/editCar.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/myCar.dart';
import 'package:p2p_car_sharing_app/screens/main_page/cars_page/searched_car_details.dart';
import 'package:p2p_car_sharing_app/screens/admin_page/adminTransactions.dart';
import 'package:p2p_car_sharing_app/screens/main_page/search.dart';
import 'package:p2p_car_sharing_app/screens/others/edit_profile.dart';
import 'package:p2p_car_sharing_app/screens/splashscreen.dart';
import 'models/admin_transaction_model.dart';
import 'screens/authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51JofQJF0ihJ2wcebWHseDcTbPbp3qi26KldhgBxrEQRwxDcMu9f1lQPNah2wRuhZZPc0IJo3dBc1S7jEnIG5cQIu0045QYNkKC';
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
          name: '/login/homeFast',
          page: () => Home(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 300),
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
        GetPage(
          name: '/login/home/profile/myCar',
          page: () => MyCar(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: '/login/home/profile/myCar/addCar',
          page: () => AddCar(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 600),
        ),
        GetPage(
          name: '/search',
          page: () => Search(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/carPage',
          page: () => Home(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 150),
        ),
        GetPage(
          name: '/searchCarDetails',
          page: () => SearchCarDetailPage(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 150),
        ),
        GetPage(
          name: '/renterRequest',
          page: () => RenterRequest(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 150),
        ),
        GetPage(
          name: '/bookNow',
          page: () => BookCar(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/editCar',
          page: () => EditCar(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/adminProfile',
          page: () => AdminProfile(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/adminTransaction',
          page: () => AdminTransactions(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 500),
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
