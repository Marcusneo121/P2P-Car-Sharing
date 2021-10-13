import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title,
      required this.colour,
      required this.textColor,
      required this.onPressed,
      required this.tag});

  final Color colour;
  final Color textColor;
  final String title;
  final String tag;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Hero(
        child: Material(
          elevation: 5.0,
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
          child: MaterialButton(
            onPressed: () {
              onPressed();
            },
            minWidth: 400.0,
            height: 50.0,
            child: Text(
              '$title',
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        tag: '$tag',
      ),
    );
  }
}
