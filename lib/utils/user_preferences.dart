import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p2p_car_sharing_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;
String imageURL = "";
String username = "";
String email = "";

class UserPreferences {
  // Future<void> readData() async {
  //   final SharedPreferences authSharedPreferences =
  //       await SharedPreferences.getInstance();
  //   final obtainedUID = authSharedPreferences.get('uidShared');
  //
  //   print('Read');
  //   DocumentReference documentReference =
  //   _firestore.collection("users").doc(obtainedUID.toString());
  //
  //   documentReference.get().then(
  //         (datasnapshot) {
  //         username = datasnapshot.get('studentName');
  //         email = datasnapshot.get('studentID');
  //         imageURL = datasnapshot.get('studyProgramID');
  //     },
  //   );
  // }

  static const myUser = const UserProfile(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
  );
}
