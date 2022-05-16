import 'package:borad_app/Model.dart';
import 'package:borad_app/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 100.0, 10, 10),
          child: ListView(

            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Pocket Password App',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign UP',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink
                    ),
                    child: const Text('Sign Up'),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                      final String email = nameController.text.trim();
                      final String password = passwordController.text.trim();
                      // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>login()));
                      if(email.isEmpty){
                        print("Email is Empty");

                      }
                      else{
                        if(password.isEmpty){
                          print("Password is Empty");

                        }
                        else{
                          context.read<AuthServices>().Signup(
                              email,
                              password
                          );
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>login()));

                        }
                      }

                    },
                  )),

            ],
          )),
    );
  }
}
