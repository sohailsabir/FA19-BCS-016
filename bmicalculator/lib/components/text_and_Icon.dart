

import 'package:flutter/material.dart';

class TextAndIcon extends StatelessWidget {
  TextAndIcon({required this.icon,required this.lable});
  final IconData icon;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 40.0,
        ),
        SizedBox(
          height: 13.0,
        ),
        Text(lable,
          style: TextStyle(
            color: Color(0xFF8D8E98),
            fontSize: 18,
          ),)
      ],
    );
  }
}