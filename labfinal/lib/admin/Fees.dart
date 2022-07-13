import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/admin/AddClass.dart';
import 'package:labfinal/admin/AddFees.dart';
import 'package:labfinal/admin/ViewClass.dart';
class FeesPage extends StatelessWidget {
  const FeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fees"),
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
              title: "ADD Fee Class Wise",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFees()));
              },
              icon: Icons.add_outlined,
            ),
            TeacherRepeatContainer(
              title: "Fees INFO",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewClass()));
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
