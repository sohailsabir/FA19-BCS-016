import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/Controller/auth_controller.dart';
import 'package:tiktok/View/Screen/Auth/Login_page.dart';
import 'package:tiktok/View/Widgets/glitch.dart';

import '../../Widgets/textinput.dart';
import 'package:get/get.dart';
class SignupScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController cpasswordController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlithEffect(child: const Text("Wellcome To Tiktok",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),)),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    AuthController.instance.picImage();
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                       backgroundImage: NetworkImage('https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg'),
                        backgroundColor: Colors.indigo,
                        radius: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Icon(Icons.edit,size: 20,color: Colors.black,)),),
                    ],
                  ),
                ),
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
                    controller: usernameController,
                    mylabeltext: "Username",
                    myicon: Icons.person,


                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    controller: passwordController,
                    mylabeltext: "Set Password",
                    myicon: Icons.lock,
                    toHide: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    controller: cpasswordController,
                    mylabeltext: "Comfirm Password",
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
                    onPressed: (){AuthController.instance.Signup(usernameController.text, emailController.text.trim(), cpasswordController.text, AuthController.instance.proimg);}, child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                      child: Text("Signup")),),
                ),
                InkWell(
                  child: Text("Signin"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },),

              ],
            ),
          ),
        ),
      ),
    );
  }
}