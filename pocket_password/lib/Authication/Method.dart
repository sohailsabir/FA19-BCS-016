
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/LoginPage.dart';

Future<User?>createAccount(String name,String email, String password)async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    User? user=(await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if(user!=null)
      {
        print( "Account Creation Successfull");
        return user;
      }
    else{
      print("Account creation faild");
      return user;
    }
  }catch(e){
    print(e);
    return null;
  }
}
Future<User?>Loginuser(String email, String password)async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    User? user=(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    if(user!=null)
    {
      print( "Login Successfull");
      return user;
    }
    else{
      print("Login faild");
      return user;
    }
  }catch(e){
    print(e);
    return null;
  }
}
Future logout(BuildContext context)async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }catch(e){
    print(e);
  }
}