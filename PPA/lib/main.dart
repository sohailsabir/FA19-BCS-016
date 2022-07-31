import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppa/Screen/DashBoard.dart';
import 'package:ppa/Drive/drive.dart';
import 'package:ppa/Screen/SplashScreen.dart';
Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

