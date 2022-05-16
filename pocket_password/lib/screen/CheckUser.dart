

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/LoginPage.dart';
import 'package:pocket_password/screen/DashBoard.dart';

class CheckUser extends StatelessWidget {

FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser!=null){
      return DashBoard();

    }
    else{
      return LoginPage();
    }
  }
}
