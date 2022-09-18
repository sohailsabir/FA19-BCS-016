import 'package:flutter/material.dart';
import 'package:tiktok/Component/Constants.dart';
class TextInput extends StatelessWidget {
  TextInput({required this.controller,required this.myicon,required this.mylabeltext,this.toHide=false});
  final TextEditingController controller;
  final IconData myicon;
  final String mylabeltext;
  final bool toHide;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        icon: Icon(myicon),
        labelText: mylabeltext,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),

      ),

    );
  }
}
