import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/Model/QuizBankMultli.dart';
import 'package:quizapp/Screens/resultPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain2 quizBrain2=QuizBrain2();
class Quiz2page extends StatefulWidget {
  const Quiz2page({Key? key}) : super(key: key);

  @override
  _Quiz2pageState createState() => _Quiz2pageState();
}
class _Quiz2pageState extends State<Quiz2page> {
  bool check=true;
  int right=0;
  int wronge=0;
  int remaining=9;
  int attempt=0;
  int unattempt=10;
  int questionnumber=1;
  int _counter=60;
  Timer? _timer;
  List<Icon>scoreKeeper=[
  ];
  void timerstart()
  {
    _counter=60;
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_counter>0)
        {
          _counter--;
        }
        else{
          if(quizBrain2.isfinished()==false)
          {
            _counter=60;
            questionnumber++;
            quizBrain2.nextQuestion();
            wronge=wronge+1;
            remaining=remaining-1;
            scoreKeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
          else{
            check=false;
            _timer!.cancel();
            remaining=remaining-1;
            wronge=wronge+1;
            quizBrain2.reset();

            Alert(
              context: context,
              type: AlertType.success,
              title: "Successfully",
              desc: "You have reached at the end of quiz.",

              buttons: [
                DialogButton(
                  child: Text(
                    "Result",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    _timer!.cancel();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Resultpage(att: attempt, unatt: unattempt, right: right, wronge: wronge, total: 10)));},
                  width: 120,
                ),
                DialogButton(
                  child: Text(
                    "Restart",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Quiz2page()));},
                  width: 120,
                )
              ],
            ).show();


          }

        }
      });
    });
  }
  void checkAnswer(String userAnswer) {
    String? questionAnswer = quizBrain2.getAnwerText();
    setState(() {
      if (quizBrain2.isfinished() == true) {
        check=false;
        quizBrain2.reset();
        _timer?.cancel();
        scoreKeeper = [];
        attempt=attempt+1;
        unattempt=unattempt-1;
        right=right+1;
        Alert(
          context: context,
          type: AlertType.success,
          title: "Successfully",
          desc: "You have reached at the end of quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "Result",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              onPressed: () {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Resultpage(att: attempt, unatt: unattempt, right: right, wronge: wronge, total: 10)));},
              width: 120,
            ),
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Quiz2page()));},
              width: 120,
            )
          ],
        ).show();
        quizBrain2.reset();
        _counter=60;
        questionnumber=1;

      }
      else {
        if (questionAnswer == userAnswer) {
          right=right+1;
          remaining=remaining-1;
          attempt=attempt+1;
          unattempt=unattempt-1;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        }
        else {
          attempt=attempt+1;
          unattempt=unattempt-1;
          wronge=wronge+1;
          remaining=remaining-1;
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain2.nextQuestion();
        questionnumber = questionnumber + 1;
        _counter=60;
      }
    });
  }
  @override
  void initState()
  {
    super.initState();
    timerstart();
  }
  void dispose()
  {
    super.dispose();
    _timer?.cancel();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(onPressed: (){
            quizBrain2.reset();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Resultpage(att: attempt, unatt: unattempt, right: right, wronge: wronge, total: 10)));

          }, child: Text("Quit",style: TextStyle(
            color: Colors.white,
          ),),)
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
                title: Text("Total Question:10"),
                onTap: (){},
              ),
              ListTile(
                title: Text("Remaining Question:$remaining"),
                onTap: (){},
              ),
              ListTile(
                title: Text("Right Answer:$right"),
                onTap: (){},
              ),
              ListTile(
                title: Text("Wrong Answer:$wronge"),
                onTap: (){},
              ),

            ],
          )
      ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: Text("$_counter",style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                ),),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Question#$questionnumber/10",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                      child: Center(
                        child: Text(
                          quizBrain2.getQuestionText()!,
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
                    child: TextButton(
                      onPressed: () {
                        if(check==true)
                          {
                            checkAnswer(quizBrain2.getOP1()!);
                          }

                      },
                      child:  Text(quizBrain2.getOP1()!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
                    child: TextButton(
                      onPressed: () {
                        if(check==true)
                          {
                            checkAnswer(quizBrain2.getOP2()!);
                          }


                      },
                      child:  Text(quizBrain2.getOP2()!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
                    child: TextButton(
                      onPressed: () {
                        if(check==true)
                          {
                            checkAnswer(quizBrain2.getOP3()!);
                          }



                      },
                      child:  Text(quizBrain2.getOP3()!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
                    child: TextButton(
                      onPressed: () {
                        if(check==true)
                          {
                            checkAnswer(quizBrain2.getOP4()!);
                          }



                      },
                      child:  Text(quizBrain2.getOP4()!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: scoreKeeper,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
