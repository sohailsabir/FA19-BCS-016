import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/login.dart';
import 'package:labfinal/aboutPage.dart';
import 'package:labfinal/studentLogin.dart';
import 'package:labfinal/teacherLogin.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
      backgroundColor: Colors.white,
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
            leading: Icon(Icons.person,color: Colors.deepPurple,),
            title: Text("Manager"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            },
          ),
          Divider(
            height: 7,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.people_alt,color: Colors.deepPurple,),
            title: Text("Teacher"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherLogin()));
            },
          ),
          Divider(
            height: 7,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.people_alt,color: Colors.deepPurple,),
            title: Text("Student"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentLogin()));
            },
          ),
          Divider(
            height: 7,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.info,color: Colors.deepPurple,),
            title: Text("About"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Aboutpage()));

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceButton(
              title: 'MANAGER',
              icon: Icons.person,
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
            ),
            ChoiceButton(
              title: 'TEACHER',
              icon: Icons.people_alt,
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherLogin()));
              },
            ),
            ChoiceButton(
              title: 'STUDENT',
              icon: Icons.people_alt,
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  ChoiceButton({required this.icon,required this.title,required this.onpressed});
  IconData icon;
  String title;
  VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(50.0)),
        child: Column(
          children: [
            Icon(
              icon,
              size: 70,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
