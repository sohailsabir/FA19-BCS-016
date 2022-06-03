
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_password/Authication/CreateAccount.dart';
import 'package:pocket_password/Authication/Method.dart';
import 'package:pocket_password/Authication/ResetPassword.dart';
import 'package:pocket_password/Widgets/Loading.dart';
import 'package:pocket_password/screen/DashBoard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email= TextEditingController();
  TextEditingController _password=TextEditingController();
  bool isloading=false;
  bool passVisibility=true;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isloading?Center(child: spinkit):AutofillGroup(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: Text(
                  "Wellcome",
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Sign In to Continue!",
                  style: TextStyle(
                    color: Colors.blue[200],
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: [AutofillHints.email],
                  controller: _email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: [AutofillHints.password],
                  onEditingComplete: ()=>TextInput.finishAutofillContext(),
                  controller: _password,
                  obscureText: passVisibility,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          passVisibility=!passVisibility;
                        });
                      }, icon: Icon(passVisibility?Icons.visibility:Icons.visibility_off),),
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if(_email.text.isNotEmpty&&_password.text.isNotEmpty){
                      setState(() {
                        isloading=true;
                      });
                      Loginuser(_email.text.trim(), _password.text).then((user){
                        if(user!=null){
                          setState(() {
                            isloading=false;
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                        }else{
                          setState(() {
                            isloading=false;
                          });
                        }
                      } );

                    }else{
                      print("Please fill corrent information");
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?   "),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    },
                    child: Text("Sign up",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color:Colors.blue
                    ),),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                      },
                      child: Text("Forget Password?",style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.fitHeight,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

