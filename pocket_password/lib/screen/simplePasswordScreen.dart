import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SimplePasswordScreen extends StatefulWidget {
  const SimplePasswordScreen({Key? key}) : super(key: key);

  @override
  _SimplePasswordScreenState createState() => _SimplePasswordScreenState();
}

class _SimplePasswordScreenState extends State<SimplePasswordScreen> {
  TextEditingController GeneratePassword=new TextEditingController();
  TextEditingController text=new TextEditingController();
  String passworda()
  {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    String a= String.fromCharCodes(Iterable.generate(4, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
    const number = '0123456789';
    Random rand = Random();
    String b= String.fromCharCodes(Iterable.generate(4, (_) => number.codeUnitAt(rand.nextInt(number.length))));
    return a+b;


  }
  // String GeneratePassword(){
  //   final Lenght=4;
  //   final UpperCaseletter="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  //   final LowerCaseLetter="abcdefghijklmnopqrst";
  //   final number="0123456789";
  //   String char='';
  //   char+="$UpperCaseletter$LowerCaseLetter";
  //   return List.generate(Lenght, (index) {
  //     final randomIndex=Random.secure().nextInt(char.length,);
  //     return char[randomIndex];
  //
  //   }).join('');
  //
  //
  // }
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create Simple Password"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
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
              readOnly: true,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      check=true;
                    });
                    final pass=passworda();
                    GeneratePassword.text=pass;

                  },
                  child: Text("Create Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: check==false?null:()async{
                    await FirebaseFirestore.instance.collection("PasswordBD").add({
                      'password':GeneratePassword.text,
                      'name':text.text,
                    }).then((value) {
                      print(value.id);
                      setState(() {
                        check=false;
                        const snackBar = SnackBar(
                          content: Text('Data Save Successfully'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });

                    }).catchError((error){
                      print(error);
                    });
                  },
                  child: Text("Save Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,

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
