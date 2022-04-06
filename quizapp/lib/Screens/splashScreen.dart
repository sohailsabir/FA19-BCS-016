import 'package:flutter/material.dart';
import 'package:quizapp/Screens/dashboard.dart';
import 'package:quizapp/Screens/wellcomePage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: Dashboard(),
        duration: 7000,
        imageSize: 150,
        imageSrc: "assets/sohail.png",
        text: "Muhammad Sohail Sabir\nFA19-BCS-016",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 30.0,
        ),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        backgroundColor: Colors.lightBlue.shade200,
      ),
    );
  }
}