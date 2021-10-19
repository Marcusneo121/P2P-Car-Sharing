import 'package:flutter/material.dart';

import '../constant.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: fourthColor.withOpacity(0.1),
          shadowColor: Colors.transparent,
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: primaryColor.withOpacity(0.5)),
          SizedBox(width: 16),
          Text(
            text,
            style:
                TextStyle(fontSize: 14, color: primaryColor.withOpacity(0.5)),
          ),
        ],
      );
}
