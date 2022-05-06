import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToughPasswordScreen extends StatefulWidget {
  const ToughPasswordScreen({Key? key}) : super(key: key);

  @override
  _ToughPasswordScreenState createState() => _ToughPasswordScreenState();
}

class _ToughPasswordScreenState extends State<ToughPasswordScreen> {
  TextEditingController plen=new TextEditingController();
  TextEditingController pcharlen=new TextEditingController();
  TextEditingController psymlen=new TextEditingController();
  TextEditingController pdigitlen=new TextEditingController();
  TextEditingController password=new TextEditingController();
  String passworda(int length,int charlen,int symlen,int digitlen)
  {
    int total=charlen+symlen+digitlen;
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    String a= String.fromCharCodes(Iterable.generate(charlen, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
    const number = '0123456789';
    String b= String.fromCharCodes(Iterable.generate(digitlen, (_) => number.codeUnitAt(random.nextInt(number.length))));
    const symbol="!@#%^&*()?><~";
    String c= String.fromCharCodes(Iterable.generate(symlen, (_) => symbol.codeUnitAt(random.nextInt(symbol.length))));
    String d= a+b+c;
    List list = d.split('');

    list.shuffle();
    String shuffled = list.join();

    return shuffled;
  }

  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create Tough Password"),
        backgroundColor: Colors.pink,
      ),
      body:  Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            TextField(
              controller: plen,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Length of Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: pcharlen,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Characters in the Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: psymlen,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Symbol in the Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: pdigitlen,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digit in the Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: password,
              readOnly: true,
              decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Password Like: ab@1A",
                  icon: Icon(
                    Icons.password,
                    color: Colors.pink,
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
                    int length=int.parse(plen.text);
                    int chlen=int.parse(pcharlen.text);
                    int symlen=int.parse(psymlen.text);
                    int diglen=int.parse(pdigitlen.text);
                    final pass=passworda(length,chlen,symlen,diglen);
                    password.text=pass;

                  },
                  child: Text("Create Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: check==false?null:()async{
                    await FirebaseFirestore.instance.collection("PasswordBD").add({
                      'password':password.text,
                      'name':'Tough Password',
                    }).then((value) {
                      print(value.id);
                    }).catchError((error){
                      print(error);
                    });
                  },
                  child: Text("Save Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
