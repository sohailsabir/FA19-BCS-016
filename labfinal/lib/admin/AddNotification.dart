import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class AddNotification extends StatefulWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  TextEditingController ntitle=TextEditingController();
  TextEditingController nbody=TextEditingController();
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(message.notification!.body.toString()),
    //     duration: Duration(seconds: 10),
    //   ),
    //   );
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(message.data['name'].toString()),
    //     duration: Duration(seconds: 10),
    //   ),
    //   );
    // });
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
    FirebaseMessaging.instance.subscribeToTopic('Flutter');
  }


  void sendPushmessage(String title,String body)async{
    print("call");
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAQHRE4VM:APA91bHtAuBX27TdNUvQkULgsgBcFZSBFAHZkVUhTTxSDyn-sX3pkA7GZz8zuMrcyqVw_l8krLMHTeOy79m4OK0iv3sPgHxRbEz08LdokFUSlXWyjz1P2QZZbLvE-rt_2UYfjx5KW7xn',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "/topics/Flutter",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
  void getToken()async{
    await FirebaseMessaging.instance.getToken().then((token) =>print(token) );
  }
  void requestPermission()async{
    FirebaseMessaging messaging=FirebaseMessaging.instance;

    NotificationSettings setting=await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    if(setting.authorizationStatus==AuthorizationStatus.authorized){
      print('User granted permission');
    }
    else if(setting.authorizationStatus==AuthorizationStatus.provisional){
      print("User granted provisional permission");
    }
    else{
      print("User denied or not accept permission");
    }
  }
  void listenFCM()async{
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }
  void loadFCM()async{
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notification"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: ntitle,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Empty field not allowed";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Please Enter Message Title",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.title,
                  color: Colors.deepPurple,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  BorderSide(width: 3, color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  BorderSide(width: 3, color: Colors.deepPurple),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: nbody,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Empty field not allowed";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Please Enter Message Body",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.subject_sharp,
                  color: Colors.deepPurple,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  BorderSide(width: 3, color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  BorderSide(width: 3, color: Colors.deepPurple),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(onPressed: (){
              if(ntitle.text.isNotEmpty&&nbody.text.isNotEmpty){
                sendPushmessage(ntitle.text, nbody.text);

                  FirebaseFirestore.instance.collection('message').add({
                    'title':ntitle.text,
                    'body':nbody.text,
                  });
                FirebaseFirestore.instance.collection('Acedemy').doc(FirebaseAuth.instance.currentUser!.uid).collection('message').add({
                  'title':ntitle.text,
                  'body':nbody.text,
                });
                nbody.clear();
                ntitle.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Message send Successfully"),
                  duration: Duration(seconds: 5),
                ),
                );


              }
              else{
                const snackBar = SnackBar(
                  content: Text('Please fill all data'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }, child: Text("Send"),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 35, vertical: 15),
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),

          )
        ],
      ),
    );
  }
}
