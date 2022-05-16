
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/LoginPage.dart';
import 'package:pocket_password/Authication/Method.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email= TextEditingController();
  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();
  bool isloading=false;
  final _form = GlobalKey<FormState>();
  bool emailValidation(String e){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    return emailValid;
  }

  bool passVisibility=true;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isloading?Center(child: CircularProgressIndicator(),):Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                  "Sign Up to Continue!",
                  style: TextStyle(
                    color: Colors.blue[200],
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _email,
                  validator: (value){
                    if(!emailValidation(value!)||value.isEmpty){
                      return "Please enter valid email adddress";
                    }
                    return null;
                  },
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _username,
                  validator: (value){
                    if(value!.isEmpty||value.length<4){
                      return "Please enter 4 character";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: "Username",
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
                child: TextFormField(
                  controller: _password,
                  validator: (value){
                    if(value!.isEmpty||value.length<7){
                      return "Please enter at least 7 character";
                    }
                    return null;
                  },
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
                    if(!_form.currentState!.validate()){
                      return;
                    }
                    if(_form.currentState!.validate()){
                      setState(() {
                        isloading=true;
                      });
                      createAccount(_username.text, _email.text.trim(), _password.text).then((user){
                        if(user!=null){
                          setState(() {
                            isloading=false;
                          });
                          print("Login successfully");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                        }
                        else{
                          print("Login Failed");
                          setState(() {
                            isloading=false;
                          });
                        }
                      });

                    }
                    else{
                      print("Please enter feild");
                    };

                  },
                  child: Text(
                    "Sign Up",
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
                  Text("Already have an account?   "),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: Text("Sign In",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color:Colors.blue
                    ),),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.fitHeight,
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

