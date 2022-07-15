import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> onBackgroundHandler(RemoteMessage remoteMessage)async{
  log('message received!${remoteMessage.notification!.title}');
}

class NotificationServices{

 static Future<void>Initialize()async{
    NotificationSettings setting=await FirebaseMessaging.instance.requestPermission();
    if(setting.authorizationStatus==AuthorizationStatus.authorized){
      FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);
      String? token=await FirebaseMessaging.instance.getToken();
      if(token!=null)
        {
          log(token);
        }



      log('Notification Initialize');

    }
  }
}