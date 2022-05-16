import 'package:chatapp/Authication/Method.dart';
import 'package:flutter/material.dart';

class Wellocme extends StatelessWidget {
  const Wellocme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: (){logout(context);},
          child: Text("Logout"),
        ),
      ),
    );
  }
}
