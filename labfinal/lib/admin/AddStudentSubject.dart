import 'package:flutter/material.dart';

class AddStudentSubject extends StatefulWidget {
   AddStudentSubject({required this.docid});
   final String docid;

  @override
  _AddStudentSubjectState createState() => _AddStudentSubjectState();
}

class _AddStudentSubjectState extends State<AddStudentSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Student Subject"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
