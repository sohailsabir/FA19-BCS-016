

import 'package:flutter/material.dart';
import 'package:ppa/Component/Loading.dart';
import 'package:ppa/db/passwordmodel.dart';

import '../Services/UserServices.dart';

class CustomPasswordScreen extends StatefulWidget {
  const CustomPasswordScreen({Key? key}) : super(key: key);

  @override
  _CustomPasswordScreenState createState() => _CustomPasswordScreenState();
}

class _CustomPasswordScreenState extends State<CustomPasswordScreen> {
  TextEditingController GeneratePassword=new TextEditingController();
  TextEditingController text=new TextEditingController();
  bool isloading=false;
  var _userService=UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create Custom Password"),
        backgroundColor: Colors.teal,
      ),
      body: isloading?saveloading:Container(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: Column(
          children: [
            TextField(

              controller: text,
              decoration: InputDecoration(
                  label: Text("Enter name of password",style: TextStyle(color: Colors.teal),),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal,
                        width: 2.0),
                  ),
                  hintText: "e.g: facebook",
                  icon: Icon(
                    Icons.title,
                    color: Colors.teal,
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
                    borderSide: BorderSide(color: Colors.teal,
                        width: 2.0),
                  ),
                  hintText: "Password Like: abcd1234",
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:()async{
                    FocusManager.instance.primaryFocus?.unfocus();

                    if(text.text.isNotEmpty&&GeneratePassword.text.isNotEmpty){
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
                    else{
                      const snackBar = SnackBar(
                        content: Text('Please fill all text feild'),
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
            Container(
              margin: EdgeInsets.only(top: 100),
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.png"),
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
