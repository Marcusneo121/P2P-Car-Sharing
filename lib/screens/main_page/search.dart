import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_car_sharing_app/controllers/searchController.dart';
import '../../constant.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? snapshotSearchData;
  bool isExecuted = false;
  String uid = "";

  @override
  void initState() {
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF647dee),
        onPressed: () {
          setState(() {
            searchController.clear();
            isExecuted = false;
          });
        },
        child: Icon(Icons.clear),
      ),
      appBar: getAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //SizedBox(height: 180),
                //Lottie.asset('assets/nothinghere.json', width: 150, height: 150),
                // SizedBox(height: 10),
                // Text(
                //   "Oops! Nothing here.",
                //   style: TextStyle(fontSize: 14),
                // ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 112,
                      child: TextField(
                        onChanged: (text) {},
                        controller: searchController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          fillColor: fourthColor.withOpacity(0.1),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          hintText: 'e.g. Honda',
                          hintStyle: TextStyle(
                              color: primaryColor.withOpacity(0.5),
                              fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    GetBuilder<SearchController>(
                      init: SearchController(),
                      builder: (val) {
                        return IconButton(
                          onPressed: () {
                            val.queryData(searchController.text).then((value) {
                              snapshotSearchData = value;
                              setState(() {
                                isExecuted = true;
                              });
                            });
                          },
                          icon: Icon(
                            Icons.search_rounded,
                            color: primaryColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                getSearchResult()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchedData() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshotSearchData!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.toNamed("/searchCarDetails", arguments: [
                uid.toString(),
                snapshotSearchData!.docs[index].id.toString()
              ]);
            },
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  snapshotSearchData!.docs[index]['carPic'].toString()),
            ),
            title: Text(
              snapshotSearchData!.docs[index]['carName'].toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            subtitle: Text(
              "RM " + snapshotSearchData!.docs[index]['price'] + " /per day",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        },
      ),
    );
  }

  getSearchResult() {
    return isExecuted == true
        ? searchedData()
        : Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Lottie.asset('assets/searching.json',
                      width: 290, height: 260),
                  // SizedBox(height: 10),
                  Text(
                    "Search Cars That You Like!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Search',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 3),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () {
                //Get.offNamed('/login/home');
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
                size: 20,
              ),
            ),
          )),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
      elevation: 0.0,
      // actions: [
      //   Icon(
      //     Icons.search_rounded,
      //     color: primaryColor,
      //   ),
      //   SizedBox(
      //     width: 20,
      //   ),
      // ],
    );
  }
}
