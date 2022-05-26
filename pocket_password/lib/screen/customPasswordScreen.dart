import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_password/Authication/Method.dart';
import 'package:pocket_password/Widgets/Loading.dart';

class CustomPasswordScreen extends StatefulWidget {
  const CustomPasswordScreen({Key? key}) : super(key: key);

  @override
  _CustomPasswordScreenState createState() => _CustomPasswordScreenState();
}

class _CustomPasswordScreenState extends State<CustomPasswordScreen> {
  TextEditingController GeneratePassword=new TextEditingController();
  TextEditingController text=new TextEditingController();
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create Custom Password"),
        backgroundColor: Colors.blue,
      ),
      body: isloading?saveloading:Container(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: Column(
          children: [
            TextField(

              controller: text,
              decoration: InputDecoration(
                  label: Text("Enter name of password"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                        width: 2.0),
                  ),
                  hintText: "e.g: facebook",
                  icon: Icon(
                    Icons.title,
                    color: Colors.blue,
                  )
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(

              controller: GeneratePassword,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                        width: 2.0),
                  ),
                  hintText: "Password Like: abcd1234",
                  icon: Icon(
                    Icons.password,
                    color: Colors.blue,
                  )
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:()async{

                    if(text.text.isNotEmpty&&GeneratePassword.text.isNotEmpty){
                      setState(() {
                        isloading=true;
                      });
                      final uid= await getUserId();
                      print(uid);

                      await FirebaseFirestore.instance.collection("PasswordBD").doc(uid).collection('password').add({
                        'password':GeneratePassword.text,
                        'name':text.text,
                      }).then((value) {
                        setState(() {
                          isloading=false;
                        });
                        text.clear();
                        GeneratePassword.clear();
                        const snackBar = SnackBar(
                          content: Text('Data Save Successfully'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);


                      }).catchError((error){
                        print(error);
                      });
                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Please fill all text feild'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
                  child: Text("Save Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(15),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/simple.png"),
                    fit: BoxFit.fitHeight,
                  )
              ),
            ),
          ],
        ),
      ),

    );
  }
}
