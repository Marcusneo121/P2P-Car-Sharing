import 'package:flutter/material.dart';
import 'package:p2p_car_sharing_app/screens/main_page/favourites.dart';
import 'package:p2p_car_sharing_app/screens/main_page/profile.dart';
import 'package:p2p_car_sharing_app/screens/main_page/requests.dart';

import 'cars.dart';

class CarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Cars();
    //Container(color: Colors.red)
  }
}

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Favourite();
  }
}

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Request();
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Profile();
  }
}
