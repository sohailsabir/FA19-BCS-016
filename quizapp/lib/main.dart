import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/Screens/Quiz2page.dart';
import 'package:quizapp/Screens/splashScreen.dart';

import 'Screens/Quiz1page.dart';
void main()
{WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),

  ));
}

