import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _email= TextEditingController();
  final _form = GlobalKey<FormState>();
  bool emailValidation(String e){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    return emailValid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Receive and email to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.teal
                ),),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  cursorColor: Colors.teal,
                  controller: _email,
                  validator: (value){
                     if(!emailValidation(value!)||value.isEmpty){
                      return "Please enter valid email adddress";
                     }return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.email,color: Colors.teal,),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if(!_form.currentState!.validate()){
                      return;
                    }
                    if(_form.currentState!.validate()){
                      verifyEmail();
                    }


                  },
                  icon: Icon(Icons.mail_outline),
                  label: Text("Reset Password",style: TextStyle(fontSize: 20.0),),

                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
  Future verifyEmail()async{
    try{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=>Center(child: CircularProgressIndicator(),));
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      final snackBar = SnackBar(
        content: Text("Password Reset Email Send"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);

    }on FirebaseAuthException catch(e){

      Navigator.pop(context);
      print(e);
      final snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }
}
