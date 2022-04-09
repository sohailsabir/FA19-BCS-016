
import 'package:flutter/material.dart';

class RepeatContainer extends StatelessWidget {
  RepeatContainer({required this.colors,this.cardWidget});
  final Color colors;
  final Widget? cardWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardWidget,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}