import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    fontFamily: 'Poppins',
  ),
  filled: true,
  fillColor: Color(0xFF252525),
  contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 19.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF444444), width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF7879F1), width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);
