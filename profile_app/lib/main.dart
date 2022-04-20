import 'package:flutter/material.dart';


void main()
{
  runApp(ProfileApp());
}
class ProfileApp extends StatelessWidget {
  const ProfileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.brown.shade300,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text('Profile App'),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/sohail.png'),
                  backgroundColor: Colors.white,
                  radius: 70.0,
                ),
                Text('Muhammad Sohail Sabir',
                style: TextStyle(
                  fontFamily: 'Courgette',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
                Text('FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'SmoochSans',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0,
                ),),
                SizedBox(
                  height: 50.0,
                  child: Divider(
                    thickness: 4.0,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                    ),
                    title: Text("+923087893347",
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0,
                      color: Colors.brown.shade300
                    ),),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                    ),
                    title: Text("sohailsabir6565@gmail.com",
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0,
                      color: Colors.brown.shade300
                    ),),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                  child: ListTile(
                    title: Text('About Me:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSansPro'
                    ),),
                    subtitle: Text('My name is Muhammad Sohail Sabir.I\'m Student of COMSATS University Islamabad Vehari Campus.I\'m from Vehari.I start work in flutter on September 2020.  ',
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      fontSize: 15.0,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
