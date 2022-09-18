import 'package:flutter/material.dart';
import 'package:tiktok/Controller/auth_controller.dart';
import 'package:tiktok/View/Screen/Auth/Signup.dart';
import 'package:tiktok/View/Widgets/glitch.dart';

import '../../Widgets/textinput.dart';
class LoginScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(child: const Text("Tiktok",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),)),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInput(
                  controller: emailController,
                  mylabeltext: "Email",
                  myicon: Icons.email,


                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInput(
                  controller: passwordController,
                  mylabeltext: "Password",
                  myicon: Icons.lock,
                  toHide: true,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo
                  ),
                  onPressed: (){
                    AuthController.instance.login(emailController.text.trim(), passwordController.text);
                  }, child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    child: Text("Login")),),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Text("SignUp"),
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                },),

            ],
          ),
        ),
      ),
    );
  }
}
