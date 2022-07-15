import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:labfinal/PDFFuction/pdfservices.dart';
import 'package:labfinal/admin/ViewTeacher.dart';
import 'package:labfinal/admin/add%20teacher.dart';
class TeacherPage extends StatefulWidget {
  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List Pdfdata = [];
  bool loading=false;
  final Pdfservices _pdfservices=Pdfservices();

  getData() async {
    final uid = await getUserId();
    await FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection("teacher").get().then((value) {
      for(var i in value.docs) {
        Pdfdata.add(i.data());


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Teacher"),
        backgroundColor: Colors.deepPurple,
      ),
      body: loading?saveloading:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.webp"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            TeacherRepeatContainer(
              title: "ADD TEACHER",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTeacher()));
              },
              icon: Icons.add_outlined,
            ),
            TeacherRepeatContainer(
              title: "TEACHER INFO",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewTeacher()));
              },
              icon: Icons.info,
            ),
            TeacherRepeatContainer(
              title: "PRINT TEACHER CONTACT",
              onpressed: ()async{
                await getData();
                if(Pdfdata.isNotEmpty)
                {

                  final data=await _pdfservices.createPdf(Pdfdata);
                  _pdfservices.saveAndLanchFile(data, "teachercontact.pdf");
                  Pdfdata.clear();

                }

              },
              icon: Icons.download_rounded,
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
                textAlign: TextAlign.center,
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
