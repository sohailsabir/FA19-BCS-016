

import 'package:flutter/material.dart';
import 'package:ppa/Screen/CheckUser.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: CheckUser(),
        duration: 5000,
        imageSize: 130,
        imageSrc: "assets/bg.png",
        backgroundColor: Colors.teal.shade50,
      ),
    );
  }
}
