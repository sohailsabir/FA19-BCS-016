import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
class UserNotication extends StatefulWidget {
  const UserNotication({Key? key}) : super(key: key);

  @override
  _UserNoticationState createState() => _UserNoticationState();
}

class _UserNoticationState extends State<UserNotication> {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;



  @override
  void initState() {
    super.initState();
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
    FirebaseMessaging.instance.subscribeToTopic('Flutter');
  }

  void sendPushmessage()async{
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
              'body': 'Test Body',
              'title': 'Test Title 2'
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
        title: Text("Notification"),
      ),
      body: GestureDetector(
        onTap: (){
          sendPushmessage();
        },
          child: Container(
        color: Colors.red,
        height: 40,
        width: 40,
      )),
    );
  }
}
