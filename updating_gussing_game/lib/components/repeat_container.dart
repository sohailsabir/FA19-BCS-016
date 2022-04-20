
import 'package:flutter/material.dart';

class RepeatContainer extends StatelessWidget {
  RepeatContainer({required this.colors,this.cardWidget,this.onpressed});
  final Color colors;
  final Widget? cardWidget;
  final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        child: cardWidget,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}