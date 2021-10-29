import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

String obtainedUID = "";

class AdminHome extends StatefulWidget {
  static String id = 'adminHome_screen';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     duration: Duration(milliseconds: 800),
        //     content: Text(
        //       'Logout Instead.',
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontFamily: 'Poppins',
        //         fontWeight: FontWeight.w600,
        //       ),
        //     )));
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 25.0,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        AuthBinding().dependencies();
                        AuthController().signOut();
                      },
                      child: Text('Logout'),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    IconButton(
                      icon: new Icon(
                        Icons.settings_rounded,
                        size: 27.0,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    IconButton(
                      icon: new Icon(
                        Icons.logout_rounded,
                        size: 27,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Admin Home',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      obtainedUID,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    uidShared();
  }

  Future<void> uidShared() async {
    final SharedPreferences stayLoginShared =
        await SharedPreferences.getInstance();
    setState(() {
      obtainedUID = stayLoginShared.get('uidShared').toString();
    });
  }
}
