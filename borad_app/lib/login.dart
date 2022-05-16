import 'package:borad_app/Model.dart';
import 'package:borad_app/home.dart';
import 'package:borad_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
                    'Sign in',
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
                    child: const Text('Login'),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>home()));
                      final String email = nameController.text.trim();
                      final String password = passwordController.text.trim();
                      if(email.isEmpty){
                        print("Email is Empty");
                      }else{
                        if(password.isEmpty){
                          print("password is Empty");
                        }
                        else{
                          context.read<AuthServices>().login(email, password);
                        }
                      }
                    },
                  )),
              Row(
                children: [
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>signup()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
