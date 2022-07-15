import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/PDFFuction/All%20Studentpdf.dart';
import 'package:labfinal/PDFFuction/StudentContact.dart';
import 'package:labfinal/PDFFuction/pdfTeacher.dart';
import 'package:labfinal/admin/ClassPage.dart';
import 'package:labfinal/admin/Fees.dart';
import 'package:labfinal/admin/StudentPage.dart';
import 'package:labfinal/admin/SubjectPage.dart';
import 'package:labfinal/admin/Teacherpage.dart';

import '../PDFFuction/pdfservices.dart';
class PrintPage extends StatefulWidget {
  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  List Pdfdata = [];
  List StudentPdfdata = [];
  List TeacherPdfdata = [];


  bool loading=false;

  final Pdfservices _pdfservices=Pdfservices();
  final PdfservicesAllStudent _pdfservicesAllStudent=PdfservicesAllStudent();
  final PdfTeacherservices _pdfTeacherservices=PdfTeacherservices();

  getTeacherData() async {
    final uid = await getUserId();
    await FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection("teacher").get().then((value) {
      for(var i in value.docs) {
        TeacherPdfdata.add(i.data());


      }
    });
  }

  getStudentData() async {
    final uid = await getUserId();
    await FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection("student").get().then((value) {
      for(var i in value.docs) {
        StudentPdfdata.add(i.data());


      }
    });
  }

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
        backgroundColor: Colors.deepPurple,
        title: Text("All Info"),

      ),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.webp'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(child: RepeatContainer(
                  title: "Print Teacher Contact",
                  icon: Icons.download_rounded,
                  onpressed: ()async{
                    await getData();
                    if(Pdfdata.isNotEmpty)
                    {

                      final data=await _pdfservices.createPdf(Pdfdata);
                      _pdfservices.saveAndLanchFile(data, "teachercontact.pdf");
                      Pdfdata.clear();

                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Data not available'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }

                  },
                ),),
              ],
            ),
            Row(
              children: [
                Expanded(child: RepeatContainer(
                  title: "Print Student Contact",
                  icon: Icons.download_rounded,
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentContact()));


                  },
                ),),
              ],
            ),
            Row(
              children: [
                Expanded(child: RepeatContainer(
                  title: "Print All Students Info",
                  icon: Icons.download_rounded,
                  onpressed: ()async{
                    await getStudentData();
                    if(StudentPdfdata.isNotEmpty)
                    {

                      final data=await _pdfservicesAllStudent.createPdf(StudentPdfdata);
                      _pdfservicesAllStudent.saveAndLanchFile(data, "Students.pdf");
                      StudentPdfdata.clear();

                    }
                   else{
                      const snackBar = SnackBar(
                        content: Text('Data not available'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
                ),),
              ],
            ),
            Row(
              children: [
                Expanded(child: RepeatContainer(
                  title: "Print All Teacher Info",
                  icon: Icons.download_rounded,
                  onpressed: ()async{
                    await getTeacherData();
                    if(TeacherPdfdata.isNotEmpty)
                    {

                      final data=await _pdfTeacherservices.createPdf(TeacherPdfdata);
                      _pdfTeacherservices.saveAndLanchFile(data, "Teachers.pdf");
                      TeacherPdfdata.clear();

                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Data not available'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RepeatContainer extends StatelessWidget {
  RepeatContainer({required this.onpressed,required this.title,this.icon});

  String title;
  IconData? icon;
  VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
            ),),
            Icon(icon,color: Colors.deepPurple,size: 40,),
          ],
        ),),
        margin: EdgeInsets.all(10.0),
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: Colors.deepPurple,
                width: 4
            )
        ),
      ),
    );
  }
}
