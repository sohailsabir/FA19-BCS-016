import 'package:flutter/material.dart';
import 'package:pocket_password/screen/CheckUser.dart';
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
        imageSrc: "assets/background.png",
        text: "Pocket Password",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
          fontSize: 30.0,
          color: Colors.blue
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
