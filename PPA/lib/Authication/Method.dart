


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ppa/Authication/LoginPage.dart';

Future<User?>createAccount(String name,String email, String password)async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    User? user=(await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if(user!=null)
      {
        return user;
      }
    else{
      return user;
    }
  }catch(e){
    return null;
  }
}
Future<User?>Loginuser(String email, String password)async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    User? user=(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    if(user!=null)
    {
      return user;
    }
    else{
      return user;
    }
  }catch(e){

    return null;
  }
}
Future logout(BuildContext context)async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    await _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
  }catch(e){
    print(e);
  }
}
Future<String>getUserId()async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  return await(_auth.currentUser!.uid);
}