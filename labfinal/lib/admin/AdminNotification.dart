import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:labfinal/Authentication/login.dart';
import 'package:http/http.dart' as http;
import 'package:labfinal/admin/AddNotification.dart';
import 'package:labfinal/admin/View%20Notification.dart';

class NoticationPage extends StatefulWidget {
  const NoticationPage({Key? key}) : super(key: key);

  @override
  _NoticationPageState createState() => _NoticationPageState();
}

class _NoticationPageState extends State<NoticationPage> {

  // void getInitialMessage()async{
  //  RemoteMessage? message=await FirebaseMessaging.instance.getInitialMessage();
  //  if(message!=null){
  //    if(message.data['page']=='email'){
  //      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
  //    }
  //    else{
  //      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //        content: Text("Invalid Page"),
  //        duration: Duration(seconds: 5),
  //        backgroundColor: Colors.red,
  //      ),
  //      );
  //
  //    }
  //  }
  // }
  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onMessage.listen((message) {
    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //      content: Text(message.notification!.body.toString()),
    //    duration: Duration(seconds: 10),
    //  ),
    //  );
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(message.data['name'].toString()),
    //     duration: Duration(seconds: 10),
    //   ),
    //   );
    // });

  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
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
              title: "Add Notification",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotification()));
              },
              icon: Icons.add_outlined,
            ),
            TeacherRepeatContainer(
              title: "View Notification",
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNotification()));
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
