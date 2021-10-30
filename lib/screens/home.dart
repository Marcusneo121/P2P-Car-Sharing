import 'package:flutter/material.dart';
import 'main_page/mainBottomNavRouter.dart';

class Home extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CarPage(),
    FavouritePage(),
    RequestsPage(),
    ProfilePage(),
  ];

  @override
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
        backgroundColor: Color(0xFFEDEDED),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          backgroundColor: Color(0xFFFFFFFF),
          //backgroundColor: Color(0xFF282828),
          selectedItemColor: Color(0xFF7879F1),
          unselectedItemColor: Color(0xFF9A9A9A),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.directions_car_rounded),
              title: new Text(
                'Cars',
                style: TextStyle(fontSize: 14),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite_rounded),
              title: new Text(
                'Favourite',
                style: TextStyle(fontSize: 14),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.error_rounded),
              title: new Text(
                'Request',
                style: TextStyle(fontSize: 14),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person_rounded),
              title: new Text(
                'Account',
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
