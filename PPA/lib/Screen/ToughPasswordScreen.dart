

import 'dart:math';

import 'package:flutter/material.dart';

import '../Component/Loading.dart';
import '../Services/UserServices.dart';
import '../db/passwordmodel.dart';

class ToughPasswordScreen extends StatefulWidget {
  const ToughPasswordScreen({Key? key}) : super(key: key);

  @override
  _ToughPasswordScreenState createState() => _ToughPasswordScreenState();
}

class _ToughPasswordScreenState extends State<ToughPasswordScreen> {
  TextEditingController text=new TextEditingController();
  TextEditingController plen=new TextEditingController();
  TextEditingController pcharlen=new TextEditingController();
  TextEditingController psymlen=new TextEditingController();
  TextEditingController pdigitlen=new TextEditingController();
  TextEditingController password=new TextEditingController();
  bool isloading=false;
  var _userService=UserServices();
  String passworda(int charlen,int symlen,int digitlen)
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
        backgroundColor: Colors.teal,
      ),
      body:  isloading?saveloading:Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            TextField(
              controller: text,
              decoration: InputDecoration(
                hintText: "e.g:facebook",
                  label: Text("Enter Password name",style: TextStyle(color: Colors.teal),),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  icon: Icon(
                    Icons.title,
                    color: Colors.teal,
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
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.teal,
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
                  labelStyle: TextStyle(color: Colors.teal),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.teal,
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
                  labelStyle: TextStyle(color: Colors.teal),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.teal,
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
                    borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Password Like: ab@1A",
                  icon: Icon(
                    Icons.password,
                    color: Colors.teal,
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

                      if(psymlen.text.isNotEmpty&&pdigitlen.text.isNotEmpty&&pcharlen.text.isNotEmpty)
                        {

                          int chlen=int.parse(pcharlen.text);
                          int symlen=int.parse(psymlen.text);
                          int diglen=int.parse(pdigitlen.text);
                          final pass=passworda(chlen,symlen,diglen);
                          password.text=pass;
                          check=true;
                        }
                      else{
                        const snackBar = SnackBar(
                          content: Text('Please Fill All Feild'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });


                  },
                  child: Text("Create Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(15),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: check==false?null:()async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    if(text.text.isNotEmpty&&password.text.isNotEmpty){
                      var _ModelPass=ModelPass();
                      _ModelPass.title=text.text;
                      _ModelPass.pass=password.text;
                      var result=await _userService.SaveUser(_ModelPass);
                      print(result);
                      text.clear();
                      password.clear();
                      pdigitlen.clear();
                      psymlen.clear();
                      pcharlen.clear();


                      if(result!=null){
                        const snackBar = SnackBar(
                          content: Text('Save Data Successfully'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text('Sothing went wrong'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);

                      }



                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text("Please fill all field"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }

                  },
                  child: Text("Save Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(15),


                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg.png"),
                      fit: BoxFit.scaleDown,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
