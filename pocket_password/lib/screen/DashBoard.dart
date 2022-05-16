import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/Method.dart';
import 'package:pocket_password/screen/ToughPasswordScreen.dart';
import 'package:pocket_password/screen/ViewPassword.dart';
import 'package:pocket_password/screen/aboutpage.dart';
import 'package:pocket_password/screen/simplePasswordScreen.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: Text("Pocket Password App"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){logout(context);}, icon: Icon(Icons.logout),),
        ],
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
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/logo.png'),
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
                color: Colors.blue.shade300,
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
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                logout(context);
              },
            ),

          ],
        ),
      ),
      body: SafeArea(
         child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg1.png"),
                    fit: BoxFit.fill),
              ),
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
                   height: 15.0,
                 ),
                 OptionButton(
                   text: "Create Tough Password",
                   onpressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ToughPasswordScreen()));
                   },
                 ),
                 SizedBox(
                   height: 15.0,
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
        elevation: 10,
        shadowColor: Colors.blue,
        primary: Colors.blue.shade400,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),

    );
  }
}