import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:p2p_car_sharing_app/components/input_widget.dart';
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
  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  String fromDate = "2021-10-18 12:39:32.581509";
  //static final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  File? _image;

  final picker = ImagePicker();

  Future getGalleryImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void initState() {
    print(_dateTime);
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
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Car Brand',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
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
                        height: 2,
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
                        height: 2,
                      ),
                      input('e.g. 2020', yearController),
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
                        height: 2,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fourthColor.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 6, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Select Pickup Location',
                                  style: TextStyle(
                                      color: primaryColor.withOpacity(0.8),
                                      fontSize: 14),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.location_on_outlined,
                                      color: tertiaryColor,
                                    ))
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 8,
                      ),
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
                      Text(
                        'Testing Location',
                        style: pageStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      input('e.g. KLCC Tower', locationController),
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
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          customApplyButton(() {
                            //Add button
                            //Get.back();
                            if (carPlateController.text.isEmpty) {
                              Get.snackbar(
                                "Ensure information is filled",
                                "Please ensure car plate number is filled.",
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
              'Apply',
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
            const EdgeInsets.only(left: 30, right: 30, top: 14, bottom: 10),
        child: Container(
          width: double.infinity,
          height: 180.0,
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
