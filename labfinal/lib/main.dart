import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:labfinal/Authentication/Signup.dart';
import 'package:labfinal/CheckUser.dart';
import 'package:labfinal/admin/AddClass.dart';
import 'package:labfinal/admin/AddSubject.dart';
import 'package:labfinal/admin/ClassPage.dart';
import 'package:labfinal/admin/StudentPage.dart';
import 'package:labfinal/admin/SubjectPage.dart';
import 'package:labfinal/admin/Teacherpage.dart';
import 'package:labfinal/admin/ViewTeacher.dart';
import 'package:labfinal/admin/add%20teacher.dart';
import 'package:labfinal/admin/admindashboard.dart';
import 'package:labfinal/Authentication/login.dart';
import 'package:labfinal/services/notification.dart';
import 'package:labfinal/studentLogin.dart';
import 'package:labfinal/teacherLogin.dart';
import 'package:labfinal/usernotification.dart';

import 'Screen/dashboard.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}






Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   // await NotificationServices.Initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CheckUser(),
  ));
}


