import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/admin/admin_users_view.dart';
import 'package:p2p_car_sharing_app/models/admin/admin_users_model.dart';

String createdAt = "",
    userID = "",
    email = "",
    profilePic = "",
    role = "",
    username = "";

final _firestore = FirebaseFirestore.instance;

class AdminUsers extends StatefulWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  _AdminUsersState createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override
  void initState() {
    AdminUsersList.adminUsersList.clear();
    print("Admin Users List cleared");
    readData();
  }

  Future readData() async {
    if (AdminUsersList.adminUsersList.isEmpty) {
      await _firestore
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) async {
        querySnapshot.docs.forEach((doc) async {
          //print(doc.id);
          setState(() {
            userID = doc.id.toString();
            createdAt = doc["createdAt"];
            email = doc["email"].toString();
            profilePic = doc["profilePic"].toString();
            role = doc["role"].toString();
            username = doc["username"].toString();
          });

          print(userID);
          print(createdAt);
          print(email);
          print(profilePic);
          print(role);
          print(username);

          var eachUsersModel = AdminUsersModel(
            userID: userID.toString(),
            createdAt: createdAt,
            email: email.toString(),
            profilePic: profilePic.toString(),
            role: role.toString(),
            username: username.toString(),
          );

          AdminUsersList.adminUsersList.add(eachUsersModel);
          print("Transaction List added");
        });
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewOrNot = AdminUsersList.adminUsersList.isNotEmpty
        ? Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('users').snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Some Error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: AdminUsersList.adminUsersList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildAdminUsersCard(context, index),
                    );
                  }
                },
              ),
            ),
          )
        : Center(
            child: Column(
              children: [
                SizedBox(height: 180),
                Lottie.asset('assets/nothinghere.json',
                    width: 150, height: 150),
                SizedBox(height: 10),
                Text(
                  "Oooops! No User.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Users',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 21,
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.search_rounded,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       // do something
        //     },
        //   ),
        //   SizedBox(width: 4),
        // ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              children: [
                listViewOrNot,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
