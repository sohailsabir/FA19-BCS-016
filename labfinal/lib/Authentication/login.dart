import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:labfinal/Authentication/Signup.dart';
import 'package:labfinal/admin/admindashboard.dart';
import 'package:labfinal/Authentication/forgetPassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passvisibility = true;
  TextEditingController _email= TextEditingController();
  TextEditingController _password=TextEditingController();
  bool isloading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: isloading?Center(child: saveloading,):Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.webp"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 90,
              ),
              Center(
                child: Text("Manager Login",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
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
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
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
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: passvisibility,
                  decoration: InputDecoration(
                    hintText: "Enter your Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.deepPurple,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passvisibility ? Icons.visibility_off : Icons.visibility,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        setState(() {
                          passvisibility = !passvisibility;
                        });
                      },
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
                    if(_email.text.isNotEmpty&&_password.text.isNotEmpty){
                      setState(() {
                        isloading=true;
                      });
                      Loginuser(_email.text.trim(), _password.text).then((user){
                        if(user!=null){
                          setState(() {
                            isloading=false;

                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminDashboard()));
                        }
                        else{
                          setState(() {
                            isloading=false;
                          });
                        }
                      } );
                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Invalid Password'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
                  child: Text(
                    "Login",
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
                  Text("Don't have an account?   "),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));
                    },
                    child: Text("Sign up",style: TextStyle(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                      },
                      child: Text("Forget Password?",style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
