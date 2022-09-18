import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktok/View/Screen/AddVideo.dart';
import 'package:tiktok/View/Screen/DisplayScreen.dart';

const backgroundColor=Colors.black;
var buttonColor=Colors.red[400];
const borderColor=Colors.grey;

getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];
var pageindex=[
  DisplayVideoScreen(),
  Text('search'),
  AddVideoScreen(),
  Text('message'),
  Text('profile')
];