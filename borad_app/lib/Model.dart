import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth _auth;
  AuthServices(this._auth);
  Stream<User?> get authSatateChanges=>_auth.idTokenChanges();
  Future<String?> login(String email,String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "signed up";
    }catch(e){
      return e.toString();
    }
  }
  Future<String>Signup(String email,String password)async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "SignUp";
    }catch(e){
      return e.toString();
    }
  }
}