import 'package:flutter/material.dart';
import 'package:quizapp/Screens/Quiz1page.dart';

class WellcomePage extends StatelessWidget {
  const WellcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.fill,
                height: 1250.0,
                width: 600.0,

              ),
            ),
            Padding(padding:EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Let's Play Quiz,",
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,

                    ),
                  ),
                  Text("Enter your informations below",
                    style: TextStyle(
                        color: Colors.white
                    ),),
                  Spacer(),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.cyan,
                      hintText: 'FULL NAME',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),

                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Quiz1page()));
                      }, child: Text("Let's Start Quiz"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                            padding: EdgeInsets.all(20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),),
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}