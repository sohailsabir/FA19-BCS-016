import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labfinal/Screen/Signup.dart';
import 'package:labfinal/admin/AddClass.dart';
import 'package:labfinal/admin/AddSubject.dart';
import 'package:labfinal/admin/ClassPage.dart';
import 'package:labfinal/admin/StudentPage.dart';
import 'package:labfinal/admin/SubjectPage.dart';
import 'package:labfinal/admin/Teacherpage.dart';
import 'package:labfinal/admin/add%20teacher.dart';
import 'package:labfinal/admin/admindashboard.dart';
import 'package:labfinal/login.dart';
import 'package:labfinal/studentLogin.dart';
import 'package:labfinal/teacherLogin.dart';

import 'Screen/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Dashboard(),
  ));
}


