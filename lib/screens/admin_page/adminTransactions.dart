import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/components/admin_trans_view.dart';
import 'package:p2p_car_sharing_app/models/admin_transaction_model.dart';

String transactionID = "",
    createdAt = "",
    paymentMethod = "",
    carID = "",
    ownerID = "",
    ownerEmail = "",
    ownerName = "",
    ownerImage = "",
    renterID = "",
    renterEmail = "",
    renterName = "",
    renterImage = "",
    totalAmount = "";

final _firestore = FirebaseFirestore.instance;

class AdminTransactions extends StatefulWidget {
  const AdminTransactions({Key? key}) : super(key: key);

  @override
  _AdminTransactionsState createState() => _AdminTransactionsState();
}

class _AdminTransactionsState extends State<AdminTransactions> {
  @override
  void initState() {
    AdminTransList.adminTransList.clear();
    print("Admin Transactions List cleared");
    readData();
  }

  Future readData() async {
    if (AdminTransList.adminTransList.isEmpty) {
      await _firestore
          .collection('transactions')
          .get()
          .then((QuerySnapshot querySnapshot) async {
        querySnapshot.docs.forEach((doc) async {
          //print(doc.id);
          setState(() {
            transactionID = doc.id.toString();
            createdAt = doc["date"].toString();
            paymentMethod = doc["method"].toString();
            carID = doc["carID"].toString();
            ownerID = doc["ownerID"].toString();
            ownerName = doc["ownerName"].toString();
            renterID = doc["renterID"].toString();
            renterName = doc["renterName"].toString();
            totalAmount = doc["price"].toString();
          });

          DocumentReference documentReferenceRenter = _firestore
              .collection("users")
              .doc("3FitQFF1naVCUymrnrLDqzhhkme2");

          await documentReferenceRenter.get().then((datasnapshot1) async {
            setState(() {
              renterEmail = datasnapshot1.get('email');
              renterImage = datasnapshot1.get('profilePic');
              print(renterEmail);
              print(renterImage);
            });
          });

          DocumentReference documentReferenceOwner =
              _firestore.collection("users").doc(ownerID.toString());

          await documentReferenceOwner.get().then((datasnapshot2) async {
            setState(() {
              ownerEmail = datasnapshot2.get('email');
              ownerImage = datasnapshot2.get('profilePic');
            });
          });

          print(transactionID);
          print(createdAt);
          print(paymentMethod);
          print(carID);
          print(ownerID);
          print(ownerEmail);
          print(ownerName);
          print(ownerImage);
          print(renterID);
          print(renterEmail);
          print(renterName);
          print(renterImage);
          print(totalAmount);

          var eachTransModel = AdminTransModel(
            transactionID: transactionID.toString(),
            createdAt: createdAt.toString(),
            paymentMethod: paymentMethod.toString(),
            carID: carID.toString(),
            ownerID: ownerID.toString(),
            ownerEmail: ownerEmail.toString(),
            ownerName: ownerName.toString(),
            ownerImage: ownerImage.toString(),
            renterID: renterID.toString(),
            renterEmail: renterEmail.toString(),
            renterName: renterName.toString(),
            renterImage: renterImage.toString(),
            totalAmount: totalAmount.toString(),
          );

          AdminTransList.adminTransList.add(eachTransModel);
          print(AdminTransList.adminTransList[0].createdAt.toString());
          print("Transaction List added");
        });
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewOrNot = AdminTransList.adminTransList.isNotEmpty
        ? Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('transactions').snapshots(),
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
                      itemCount: AdminTransList.adminTransList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildAdminTransCard(context, index),
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
                  "No Transaction yet.",
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
          'Transactions',
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
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
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
