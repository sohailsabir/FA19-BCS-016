import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/admin/AddClass.dart';
import 'package:labfinal/admin/AddFees.dart';
import 'package:labfinal/admin/AddStudent.dart';
import 'package:labfinal/admin/AddSubject.dart';
import 'package:labfinal/admin/AdminNotification.dart';
import 'package:labfinal/admin/ClassPage.dart';
import 'package:labfinal/admin/Fees.dart';
import 'package:labfinal/admin/StudentPage.dart';
import 'package:labfinal/admin/SubjectPage.dart';
import 'package:labfinal/admin/Teacherpage.dart';
import 'package:labfinal/admin/add%20teacher.dart';
import 'package:labfinal/admin/printpage.dart';
class AdminDashboard extends StatefulWidget {


  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Fee Management App"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NoticationPage()));
            },
            icon: Icon(Icons.notification_important_rounded),
            tooltip: 'Add Noticafication',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      child: Text("F",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.deepPurple),),
                    ),
                    Text(
                      "Fee Management",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled,color: Colors.deepPurple,),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.add_outlined,color: Colors.deepPurple,),
              title: Text("Add Teacher"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTeacher()));
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.add_outlined,color: Colors.deepPurple,),
              title: Text("Add Student"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudent()));
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.add_outlined,color: Colors.deepPurple,),
              title: Text("Add Classes"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddClass()));
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.add_outlined,color: Colors.deepPurple,),
              title: Text("Add Subject"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSubject()));
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.monetization_on,color: Colors.deepPurple,),
              title: Text("Fees"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFees()));
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.logout,color: Colors.deepPurple,),
              title: Text("Logout"),
              onTap: () {
                logout(context);
              },
            ),
            Divider(
              height: 7,
              thickness: 2,
            ),
          ],
        ),
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
                  title: "Teachers",
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherPage()));
                  },
                ),),
                Expanded(child: RepeatContainer(
                  title: "Students",
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPage()));
                  },
                ),),
              ],
            ),
            Row(
              children: [
                Expanded(child: RepeatContainer(
                  title: "Classes",
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassPage()));
                  },
                ),),
                Expanded(child: RepeatContainer(
                  title: "Subjects",
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectPage()));
                  },
                ),),
              ],
            ),
            Row(
              children: [
                Expanded(child: RepeatContainer(
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FeesPage()));
                  },
                  title: "Fees",
                ),),
                Expanded(child: RepeatContainer(
                  title: "INFO",
                  onpressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PrintPage()));
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
  RepeatContainer({required this.onpressed,required this.title});

  String title;

  VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        child: Center(child: Text(title,style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 20,
        ),),),
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
