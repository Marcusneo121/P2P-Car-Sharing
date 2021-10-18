import 'package:flutter/material.dart';
import '../constant.dart';

Widget input(hintText,TextEditingController controller){
  return Container(
    height: 55,
    child: TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        fillColor: fourthColor.withOpacity(0.1),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintText: hintText,
        hintStyle: TextStyle(color:primaryColor.withOpacity(0.5),fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}