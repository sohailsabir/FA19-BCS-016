import 'package:flutter/material.dart';
import 'package:lab_mid_pocket_password_diary/UI/ToughPasswordScreen.dart';
import 'package:lab_mid_pocket_password_diary/UI/ViewPassword.dart';
import 'package:lab_mid_pocket_password_diary/UI/aboutpage.dart';
import 'package:lab_mid_pocket_password_diary/UI/simplePasswordScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PasswordApp());
}
class PasswordApp extends StatelessWidget {
  const PasswordApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pocket Password App",
      home: DashBoard(),
    );
  }
}
class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pocket Password App"),
        backgroundColor: Colors.pink,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.pink,
                      backgroundImage: AssetImage('assets/images.png'),
                    ),
                    Text(
                      "Pocket Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink.shade300,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Aboutpage(),),);
              },
            ),

          ],
        ),
      ),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              OptionButton(
                text: "Create Simple Password",
                onpressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SimplePasswordScreen()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              OptionButton(
                text: "Create Tough Password",
                onpressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ToughPasswordScreen()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              OptionButton(
                text: "Show All Password",
                onpressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPasswordScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  OptionButton({required this.text,required this.onpressed});
  final String text;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pink,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),

    );
  }
}


