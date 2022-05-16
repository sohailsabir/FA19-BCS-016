import 'package:flutter/material.dart';
class Aboutpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("About",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                Text("Pocket Password App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                Text("Version: 1.1", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),),
                Text("Made by: Muhammad Sohail Sabir & Sana Sabir", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
