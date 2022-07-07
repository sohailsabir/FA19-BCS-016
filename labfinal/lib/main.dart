import 'package:flutter/material.dart';
import 'package:labfinal/Screen/Signup.dart';
import 'package:labfinal/admin/ClassPage.dart';
import 'package:labfinal/admin/StudentPage.dart';
import 'package:labfinal/admin/SubjectPage.dart';
import 'package:labfinal/admin/Teacherpage.dart';
import 'package:labfinal/admin/admindashboard.dart';
import 'package:labfinal/login.dart';
import 'package:labfinal/studentLogin.dart';
import 'package:labfinal/teacherLogin.dart';

import 'Screen/dashboard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Dashboard(),
  ));
}


