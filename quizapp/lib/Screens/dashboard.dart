import 'package:flutter/material.dart';
import 'package:quizapp/Screens/about.dart';
import 'package:quizapp/Screens/wellcomePage.dart';
import 'package:quizapp/Screens/wellcompage2.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        actions: [
          Icon(Icons.account_circle),
        ],
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Quiz App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Aboutpage()));
                  }
              ),
             

            ],
          )
      ),
      body:  SafeArea(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                      child: Center(
                        child: Text(
                          "Select Any Quiz Type",
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AnimatedButton(
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WellcomePage()));

                    },
                    height: 70,
                    text: 'True/False',
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    transitionType: TransitionType.CENTER_LR_IN,
                    backgroundColor: Colors.cyan,
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 2,
                  ),
                  // child: ElevatedButton(
                  //   child: Text("True/False"),
                  //   onPressed: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>WellcomePage()));
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.cyan,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //     )
                  //   ),
                  // ),
                ),),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AnimatedButton(
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WellcomePage2()));
                    },
                    height: 70,
                    text: 'Multiple Choice Question',
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    transitionType: TransitionType.CENTER_LR_IN,
                    backgroundColor: Colors.cyan,
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 2,
                  ),
                  // child: ElevatedButton(
                  //   child: Text("Multiple Choice Question"),
                  //   onPressed: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>WellcomePage2()));
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //       primary: Colors.cyan,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //       )
                  //   ),
                  // ),
                ),),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
