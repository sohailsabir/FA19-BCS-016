import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppa/Component/Loading.dart';
import 'package:ppa/Services/UserServices.dart';
import 'package:ppa/db/Database.dart';
import 'package:ppa/db/passwordmodel.dart';

class SimplePasswordScreen extends StatefulWidget {
  const SimplePasswordScreen({Key? key}) : super(key: key);

  @override
  _SimplePasswordScreenState createState() => _SimplePasswordScreenState();
}

class _SimplePasswordScreenState extends State<SimplePasswordScreen> {
  TextEditingController GeneratePassword = new TextEditingController();
  TextEditingController text = new TextEditingController();
  bool isloading = false;

  String passworda() {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    String a = String.fromCharCodes(Iterable.generate(
        4, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
    const number = '0123456789';
    Random rand = Random();
    String b = String.fromCharCodes(Iterable.generate(
        4, (_) => number.codeUnitAt(rand.nextInt(number.length))));
    return a + b;
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

  // addPassword(ModelPass pass){
  //   Databaseprovider.db.addNewPasword(pass);
  //   print("Password Add Successfully");
  //
  //
  // }
  var _userService=UserServices();

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create Simple Password"),
        backgroundColor: Colors.teal,
      ),
      body: isloading
          ? saveloading
          : Container(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                children: [
                  TextField(
                    controller: text,
                    decoration: InputDecoration(
                        label: Text("Enter name of password",style: TextStyle(color: Colors.teal),),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        hintText: "e.g: facebook",
                        icon: Icon(
                          Icons.title,
                          color: Colors.teal,
                        )),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextField(
                    controller: GeneratePassword,
                    readOnly: true,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        hintText: "Password Like: abcd1234",
                        icon: Icon(
                          Icons.password,
                          color: Colors.teal,
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            check = true;
                          });
                          final pass = passworda();
                          GeneratePassword.text = pass;
                        },
                        child: Text("Create Password"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.all(15)),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: check == false ? null : ()async{
                          FocusManager.instance.primaryFocus?.unfocus();
                                if (text.text.isNotEmpty && GeneratePassword.text.isNotEmpty) {
                                  print('Good');
                                  var _ModelPass=ModelPass();
                                  _ModelPass.title=text.text;
                                  _ModelPass.pass=GeneratePassword.text;
                                  var result=await _userService.SaveUser(_ModelPass);
                                  print(result);
                                  text.clear();
                                  GeneratePassword.clear();

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
                                else {
                                  const snackBar = SnackBar(
                                    content: Text('Please Fill All Field'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                                // ModelPass passwordData=ModelPass(title: title!, pass: password!);
                                // addPassword(passwordData);
                              },
                        // onPressed: check==false?null:()async{
                        //
                        //   if(text.text.isNotEmpty&&GeneratePassword.text.isNotEmpty){
                        //     setState(() {
                        //       isloading=true;
                        //     });
                        //
                        //     final uid= await getUserId();
                        //     await FirebaseFirestore.instance.collection("PasswordBD").doc(uid).collection('password').add({
                        //       'password':GeneratePassword.text,
                        //       'name':text.text,
                        //     }).then((value) {
                        //       print(value.id);
                        //       setState(() {
                        //         isloading=false;
                        //         check=false;
                        //         const snackBar = SnackBar(
                        //           content: Text('Data Save Successfully'),
                        //         );
                        //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //         text.clear();
                        //         GeneratePassword.clear();
                        //       });
                        //
                        //     }).catchError((error){
                        //       print(error);
                        //     });
                        //   }
                        //   else{
                        //
                        //     const snackBar = SnackBar(
                        //       content: Text('Please fill all field'),
                        //     );
                        //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //   }
                        //
                        // },
                        child: Text("Save Password"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                      image: AssetImage("assets/bg.png"),
                      fit: BoxFit.fitHeight,
                    )),
                  ),
                ],
              ),
            ),
    );
  }
}
