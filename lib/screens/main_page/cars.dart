import 'package:flutter/material.dart';
import 'package:p2p_car_sharing_app/bindings/authBinding.dart';
import 'package:p2p_car_sharing_app/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

String obtainedUID = "";

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.notifications_rounded,
                      size: 27.0,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.search_rounded,
                      size: 27,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Normal Home',
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
