import 'dart:io';
//import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/components/button_widget.dart';
import 'package:p2p_car_sharing_app/components/input_widget.dart';
import 'package:p2p_car_sharing_app/controllers/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  TextEditingController carBrandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  String fromDate = "2021-10-18 12:39:32.581509";
  //static final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  File? _image;
  String mainUrl = "";
  UploadTask? task;

  File? file;
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  String url = "";
  String url1 = "";
  String url2 = "";
  String url3 = "";
  String url4 = "";

  String carID = "";

  final _firestore = FirebaseFirestore.instance;

  String fileState = "";
  final picker = ImagePicker();
  String _publicUID = "";

  Future getGalleryImage() async {
    var pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future getUID() async {
    final SharedPreferences authSharedPreferences =
        await SharedPreferences.getInstance();
    final obtainedUID = authSharedPreferences.get('uidShared');
    setState(() {
      _publicUID = obtainedUID.toString();
      print(_publicUID);
    });
  }

  void initState() {
    getUID();
    print(_dateTime.toString());
    print(DateTime.parse(fromDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color(0xffe3e3e3),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Color(0xffe3e3e3),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 3),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () {
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
    );
  }

  getBody() {
    final fileFront =
        file != null ? 'Front Image Selected' : 'Select Front Image';
    final fileLeft =
        file1 != null ? 'Left Image Selected' : 'Select Left Side Image';
    final fileRight =
        file2 != null ? 'Right Image Selected' : 'Select Right Side Image';
    final fileRear =
        file3 != null ? 'Rear End Image Selected' : 'Select Rear End Image';
    final fileInterior =
        file4 != null ? 'Interior Image Selected' : 'Select Interior Image';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36),
          child: Text(
            'Add Car',
            style: pageTitleStyle,
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      upperImagePicker(),
                      Text(
                        'Car Images',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   'Front',
                                //   style: pageStyle5.copyWith(
                                //     fontSize: 13,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 8,
                                ),
                                ButtonWidget(
                                  text: fileFront,
                                  icon: Icons.attach_file,
                                  onClicked: () {
                                    setState(() {
                                      fileState = "front";
                                    });
                                    selectFile();
                                  },
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                // Center(
                                //   child: Text(
                                //     fileName,
                                //     style: TextStyle(
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                ButtonWidget(
                                  text: fileLeft,
                                  icon: Icons.attach_file,
                                  onClicked: () {
                                    setState(() {
                                      fileState = "left";
                                    });
                                    selectFile();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                ButtonWidget(
                                  text: fileRight,
                                  icon: Icons.attach_file,
                                  onClicked: () {
                                    setState(() {
                                      fileState = "right";
                                    });
                                    selectFile();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                ButtonWidget(
                                  text: fileRear,
                                  icon: Icons.attach_file,
                                  onClicked: () {
                                    setState(() {
                                      fileState = "rear";
                                    });
                                    selectFile();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                ButtonWidget(
                                  text: fileInterior,
                                  icon: Icons.attach_file,
                                  onClicked: () {
                                    setState(() {
                                      fileState = "interior";
                                    });
                                    selectFile();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Car Brand',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. Honda', carBrandController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Model',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. Civic Type R', modelController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Year',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. 2020', yearController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Color',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. White', colorController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Engine Capacity (CC / kWh[Electric])',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. 1500 / 100', engineController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Seat Number',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      input('e.g. 5', seatController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Car Plate Number',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      //input('e.g. WQC 2918', carPlateController),
                      Container(
                        height: 55,
                        child: TextField(
                          controller: carPlateController,
                          onTap: () async {},
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            fillColor: fourthColor.withOpacity(0.1),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: 'e.g. WQC 2918',
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
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Car Available Time',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      upperDatePicker(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pick Up & Return Location',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      input('e.g. KLCC', locationController),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: fourthColor.withOpacity(0.1),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, top: 6, bottom: 6),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'Select Pickup Location',
                      //           style: TextStyle(
                      //               color: primaryColor.withOpacity(0.8),
                      //               fontSize: 14),
                      //         ),
                      //         IconButton(
                      //             onPressed: () {},
                      //             icon: Icon(
                      //               Icons.location_on_outlined,
                      //               color: tertiaryColor,
                      //             ))
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Text(
                      //   'Return Location',
                      //   style: pageStyle1.copyWith(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: fourthColor.withOpacity(0.1),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, top: 6, bottom: 6),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'Select Return Location',
                      //           style: TextStyle(
                      //               color: primaryColor.withOpacity(0.8),
                      //               fontSize: 14),
                      //         ),
                      //         IconButton(
                      //             onPressed: () {},
                      //             icon: Icon(
                      //               Icons.location_on_outlined,
                      //               color: tertiaryColor,
                      //             ))
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Price (RM)',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      input('e.g. 98', priceController),
                      // Container(
                      //   height: 60,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: fourthColor.withOpacity(0.1),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, top: 6, bottom: 6),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'RM',
                      //           style: pageStyle1.copyWith(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         Text(
                      //           '98.00',
                      //           style: pageStyle1.copyWith(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          customApplyButton(() async {
                            //Add button
                            //Get.back();
                            print("Image Path $file");
                            print("Image Path $file1");
                            print("Image Path $file2");
                            print("Image Path $file3");
                            print("Image Path $file4");
                            //validation();

                            if (_image.isNull &&
                                file.isNull &&
                                file1.isNull &&
                                file2.isNull &&
                                file3.isNull &&
                                file4.isNull &&
                                carBrandController.text.isEmpty &&
                                modelController.text.isEmpty &&
                                yearController.text.isEmpty &&
                                carPlateController.text.isEmpty &&
                                locationController.text.isEmpty &&
                                priceController.text.isEmpty &&
                                colorController.text.isEmpty &&
                                seatController.text.isEmpty &&
                                engineController.text.isEmpty &&
                                priceController.text.isEmpty) {
                              Get.snackbar(
                                "Ensure information is filled",
                                "Ensure every field is filled. Include Images",
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(milliseconds: 1500),
                                isDismissible: false,
                                backgroundColor: Color(0xFF7879F1),
                                margin: EdgeInsets.all(20),
                                animationDuration: Duration(milliseconds: 800),
                                icon: Icon(
                                  Icons.announcement_rounded,
                                  color: Colors.black,
                                ),
                                shouldIconPulse: false,
                                overlayBlur: 4,
                                overlayColor: Colors.white38,
                              );
                              return;
                            } else {
                              // EasyLoading.show(status: "Loading ...");
                              // print(_image);
                              // print(file);
                              // print(file1);
                              // print(file2);
                              // print(file3);
                              // print(file4);
                              // print(carBrandController.text);
                              // print(modelController.text);
                              // print(yearController.text);
                              // print(carPlateController.text);
                              // print(locationController.text);
                              // print(priceController.text);
                              // EasyLoading.dismiss();
                              EasyLoading.show(
                                  status: "Uploading Main Image...",
                                  dismissOnTap: false);
                              await uploadCarsImage(_image, 11);
                              EasyLoading.show(
                                  status: "Uploading Front Image...",
                                  dismissOnTap: false);
                              await uploadCarsImage(file, 0);
                              EasyLoading.show(
                                  status: "Uploading Left Image...",
                                  dismissOnTap: false);
                              await uploadCarsImage(file1, 1);
                              EasyLoading.show(
                                  status: "Uploading Right Image...",
                                  dismissOnTap: false);
                              await uploadCarsImage(file2, 2);
                              EasyLoading.show(
                                  status: "Uploading Rear Image...",
                                  dismissOnTap: false);
                              await uploadCarsImage(file3, 3);
                              EasyLoading.show(
                                  status: "Uploading Interior Image...",
                                  dismissOnTap: false);
                              await uploadCarsImage(file4, 4);
                              await addToCarList();
                              Future.delayed(Duration(seconds: 1))
                                  .then((value) async {
                                EasyLoading.showSuccess(
                                    "Car added! Will take few minutes to update.");
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) async {
                                  EasyLoading.dismiss();
                                });
                              });
                            }
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  physics: BouncingScrollPhysics(),
                )),
          ),
        ),
      ],
    );
  }

  // Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  //       stream: task.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final snap = snapshot.data!;
  //           final progress = snap.bytesTransferred / snap.totalBytes;
  //           final percentage = (progress * 100).toStringAsFixed(2);
  //
  //           return Text(
  //             '$percentage %',
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //           );
  //         } else {
  //           return Container();
  //         }
  //       },
  //     );

  // Future uploadFile() async {
  //   if (file == null) return;
  //
  //   final fileName = basename(file!.path);
  //   final destination = 'files/$fileName';
  //
  //   task = FirebaseApi.uploadFile(destination, file!);
  //   setState(() {});
  //
  //   if (task == null) return;
  //
  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //
  //   print('Download-Link: $urlDownload');
  // }

  Future addPostedCar(String carID) async {
    Map<String, dynamic> addedCar = {
      "carID": carID,
    };
    DocumentReference documentReference = _firestore
        .collection("users")
        .doc(_publicUID)
        .collection("postedCars")
        .doc(carID);
    documentReference.set(addedCar).then((doc) {
      var addedCarID = documentReference.id;
      print(addedCarID.toString());
    });
  }

  Future addToCarList() async {
    Map<String, dynamic> carAllImages = {
      "image1": url,
      "image2": url1,
      "image3": url2,
      "image4": url3,
      "image5": url4,
    };

    Map<String, dynamic> carDetails = {
      "carImages": carAllImages,
      "carName": carBrandController.text.toString() +
          " " +
          modelController.text.toString(),
      "carPic": mainUrl,
      "color": colorController.text.toString(),
      "engineCapacity": engineController.text.toString(),
      "fromDate": _dateTime.toString(),
      "toDate": _dateTime2.toString(),
      "location": locationController.text.toString(),
      "plateNumber": carPlateController.text.toString(),
      "price": priceController.text.toString(),
      "seat": seatController.text.toString(),
      "yearMade": yearController.text.toString(),
    };

    DocumentReference documentReference = _firestore.collection("cars").doc();

    documentReference.set(carDetails).then((doc) {
      carID = documentReference.id;
      print(carID.toString());
      addPostedCar(carID.toString());
    }).whenComplete(
      () {
        EasyLoading.dismiss();
      },
    );
  }

  Future uploadCarsImage(File? toUploadImg, int fileNumber) async {
    var imageFile = FirebaseStorage.instance
        .ref()
        .child('cars')
        .child('$_publicUID')
        .child("$_publicUID" +
            "_" +
            "image$fileNumber" +
            "_" +
            carPlateController.text +
            ".jpg");
    UploadTask task = imageFile.putFile(toUploadImg!);
    TaskSnapshot snapshot = await task;
    var urlGetLink = await snapshot.ref
        .getDownloadURL()
        .whenComplete(() => EasyLoading.dismiss);
    if (fileNumber == 0) {
      url = urlGetLink;
    } else if (fileNumber == 1) {
      url1 = urlGetLink;
    } else if (fileNumber == 2) {
      url2 = urlGetLink;
    } else if (fileNumber == 3) {
      url3 = urlGetLink;
    } else if (fileNumber == 4) {
      url4 = urlGetLink;
    } else if (fileNumber == 11) {
      mainUrl = urlGetLink;
    }
  }

  Future selectFile() async {
    final picker = ImagePicker();
    //final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    final result =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (result == null) {
      return;
    } else if (fileState == "front") {
      setState(() {
        file = File(result.path);
        print("Image Path $file");
      });
    } else if (fileState == "left") {
      setState(() {
        file1 = File(result.path);
        print("Image Path $file1");
      });
    } else if (fileState == "right") {
      setState(() {
        file2 = File(result.path);
        print("Image Path $file2");
      });
    } else if (fileState == "rear") {
      setState(() {
        file3 = File(result.path);
        print("Image Path $file3");
      });
    } else if (fileState == "interior") {
      setState(() {
        file4 = File(result.path);
        print("Image Path $file4");
      });
    }

    // if (result == null) return;
    // final path = result.files.single.path!;
    //
    // setState(() => file = File(path));
  }

  customApplyButton(function) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: fourthColor.withOpacity(0.12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 14, bottom: 14),
            child: Text(
              'Add To My Car List',
              style: pageStyle3.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  color: tertiaryColor),
            ),
          ),
        ),
      ),
    );
  }

  upperImagePicker() {
    return InkWell(
      onTap: () {
        getGalleryImage();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 10),
        child: Container(
          width: double.infinity,
          height: 190.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: fourthColor.withOpacity(0.1),
          ),
          child: Center(
            child: _image == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_box,
                        color: primaryColor,
                      ),
                      Text("Add Main Image",
                          style:
                              pageStyle3.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  upperDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: fourthColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'From',
                          style: pageStyle3.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _fromDate(context);
                            },
                            child: Text(
                              DateFormat.yMEd().format(_dateTime) == null
                                  ? '28 june,\n9.00 a.m'
                                  : DateFormat('yyyy-MM-dd').format(_dateTime),
                              style: pageStyle3.copyWith(
                                  fontSize: 12,
                                  color: primaryColor.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: fourthColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'To',
                          style: pageStyle3.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _toDate(context);
                            },
                            child: Text(
                              DateFormat.yMEd().format(_dateTime2) == null
                                  ? '28 june,\n9.00 a.m'
                                  : DateFormat('yyyy-MM-dd').format(_dateTime2),
                              style: pageStyle3.copyWith(
                                  fontSize: 12,
                                  color: primaryColor.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  // bool _decideWhichDayToEnable(DateTime day) {
  //   var day1 = DateTime.parse("2021-10-18 12:39:32.581509");
  //   var day2 = DateTime.parse("2021-10-20 12:39:32.581509");
  //
  //   int daysBetween(DateTime from, DateTime to) {
  //     from = DateTime(from.year, from.month, from.day);
  //     to = DateTime(to.year, to.month, to.day);
  //     return (to.difference(from).inHours / 24).round();
  //   }
  //
  //   var difference = daysBetween(day1, day2);
  //
  //   if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
  //       day.isBefore(DateTime.now().add(Duration(days: 10))))) {
  //     //DateTime.parse("2021-10-20 12:39:32.581509")
  //     return true;
  //   }
  //   return false;
  // }

  Future<Null> _fromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      //selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null)
      setState(() {
        _dateTime = picked;
        print(_dateTime);
        // fromDateController.text = DateFormat.yMd().format(insuranceDate!);
      });
  }

  Future<Null> _toDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        _dateTime2 = picked;
        print(_dateTime2);
        // fromDateController.text = DateFormat.yMd().format(insuranceDate!);
      });
  }
}
