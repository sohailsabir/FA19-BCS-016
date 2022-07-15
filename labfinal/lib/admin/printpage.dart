import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
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
