import 'package:flutter/material.dart';

class UserStudentPage extends StatefulWidget {
  const UserStudentPage({Key? key}) : super(key: key);

  @override
  _UserStudentPageState createState() => _UserStudentPageState();
}

class _UserStudentPageState extends State<UserStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Mode"),
        backgroundColor: Colors.deepPurple,
      ),

    );
  }
}
