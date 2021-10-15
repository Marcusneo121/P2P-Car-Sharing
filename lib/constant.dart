import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

const primaryColor = Color(0xFF21202A);
const secondaryColor = Color(0xFFC4C4C4);
const testingColor = Color(0xFFF1F1F1);
const tertiaryColor = Color(0xff7879F1);
const fourthColor = Color(0xff073FFF);

var pageTitleStyle = GoogleFonts.poppins(
  fontSize: 23.0,
  fontWeight: FontWeight.w800,
  color: primaryColor,
  wordSpacing: 2.5,
);

var pageStyle1 = GoogleFonts.poppins(
  fontSize: 20.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

var pageStyle2 = GoogleFonts.poppins(
  color: primaryColor,
  fontSize: 10,
  letterSpacing: 2.6,
  wordSpacing: 1,
);
var pageStyle3 = GoogleFonts.poppins(
  color: primaryColor,
  fontSize: 10,
  letterSpacing: 1,
  wordSpacing: 1,
);
