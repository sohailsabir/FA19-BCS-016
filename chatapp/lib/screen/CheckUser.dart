import 'package:chatapp/Authication/LoginPage.dart';
import 'package:chatapp/screen/Wellcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatelessWidget {

FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser!=null){
      return Wellocme();

    }
    else{
      return LoginPage();
    }
  }
}
