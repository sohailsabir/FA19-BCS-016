import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final spinkit = SpinKitFadingCube(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.lightBlueAccent : Colors.blue,
      ),
    );
  },
);