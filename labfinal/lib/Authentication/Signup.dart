import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:labfinal/admin/admindashboard.dart';
import 'package:labfinal/Authentication/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController AcedemyName=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController phonenumber=new TextEditingController();
  TextEditingController password=new TextEditingController();
  final _form=GlobalKey<FormState>();
  bool emailValidation(String e){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    return emailValid;
  }
  bool isloading=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isloading?Center(child: saveloading,):SingleChildScrollView(
          child: Container(
            height: 950,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.webp"),
                fit: BoxFit.fill,
              )
            ),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text("Create Account Here",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.deepPurple
                    ),),
                  ),
                  Divider(
                    height: 30,
                    thickness: 7,
                    endIndent: 70,
                    indent: 70,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: AcedemyName,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Empty field not allowed";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter academy name",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.home_work,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: email,
                      validator: (value){
                        if(!emailValidation(value!)||value.isEmpty){
                          return "Please enter valid email address";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: phonenumber,
                      validator: (value){
                        if(value!.isEmpty||value.length!=11){
                          return "Please enter valid phone no";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter your phone no",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: password,
                      validator: (value){
                        if(value!.isEmpty||value.length<7){
                          return "Please enter at least 7 character";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if(!_form.currentState!.validate()){
                          return;
                        }
                        if(_form.currentState!.validate()){
                          setState(() {
                            isloading=true;

                          });
                          createAccount(AcedemyName.text, email.text.trim(), password.text).then((user){
                            if(user!=null){
                              setState(() {
                                isloading=false;
                                const snackBar = SnackBar(
                                  content: Text('Create Account Successfully'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                            }
                            else{
                              setState(() {
                                isloading=false;
                              });
                              const snackBar = SnackBar(
                                content: Text('Failed to create Account'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            }
                          });
                        }
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already  have an account?   "),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: Text("Login",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color:Colors.deepPurple
                        ),),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
