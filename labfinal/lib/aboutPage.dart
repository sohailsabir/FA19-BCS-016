import 'package:flutter/material.dart';
class Aboutpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.deepPurple,
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
                Text("Fees Management App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                Text("Version: 1.1", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),),
                Text("Made by: Muhammad Sohail Sabir", style: TextStyle(
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
