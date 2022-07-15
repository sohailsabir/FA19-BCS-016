import 'package:flutter/material.dart';
import 'package:labfinal/admin/AddStudent.dart';
import 'package:labfinal/admin/ViewStudent.dart';
import 'package:labfinal/admin/studentSubject.dart';
class StudentPage extends StatelessWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.webp"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            TeacherRepeatContainer(
              title: "ADD STUDENTS",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudent()));
              },
              icon: Icons.add_outlined,
            ),
            TeacherRepeatContainer(
              title: "Add Student Subject",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentSubject()));
              },
              icon: Icons.subject_sharp,
            ),
            TeacherRepeatContainer(
              title: "STUDENT INFO",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewStudent()));
              },
              icon: Icons.info,
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherRepeatContainer extends StatelessWidget {
  TeacherRepeatContainer({required this.title,this.icon,required this.onpressed});
  IconData? icon;
  String title;
  VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),

        child: Center(
          child: Column(
            children: [
              Icon(
                icon,
                size: 100,
                color: Colors.white,
              ),
              Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
