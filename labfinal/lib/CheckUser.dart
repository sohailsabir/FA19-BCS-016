



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Screen/dashboard.dart';
import 'package:labfinal/admin/admindashboard.dart';

class CheckUser extends StatelessWidget {

FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser!=null){
      return AdminDashboard();

    }
    else{
      return Dashboard();
    }
  }
}
