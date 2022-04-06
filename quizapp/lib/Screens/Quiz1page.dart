import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizapp/Model/QuizBank.dart';
import 'package:quizapp/Screens/resultPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


QuizBank quizBank = QuizBank();

class Quiz1page extends StatefulWidget {
  const Quiz1page({Key? key}) : super(key: key);

  @override
  _Quiz1pageState createState() => _Quiz1pageState();
}


class _Quiz1pageState extends State<Quiz1page> {
  bool check=true;
  int right=0;
  int wronge=0;
  int remaining=13;
  int attempt=0;
  int unattempt=14;


  List<Icon> _scorekeeper = [];
  int questionnumber = 1;
  int _counter=20;
  Timer? _timer;
  void timerstart()
  {
    _counter=20;
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_counter>0)
        {
          _counter--;
        }
        else{
          if(quizBank.isFinished()==false)
          {
            _counter=20;
            questionnumber++;
            quizBank.nextQuestion();
            wronge=wronge+1;
            remaining=remaining-1;
            _scorekeeper.add(
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Resultpage(att: attempt, unatt: unattempt, right: right, wronge: wronge, total: 14)));},
                  width: 120,
                ),
                DialogButton(
                  child: Text(
                    "Restart",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Quiz1page()));},
                  width: 120,
                )
              ],
            ).show();


          }

        }
      });
    });
  }
  void checkAnswer(bool userAnswer) {
    bool? questionAnswer = quizBank.getQuestionAnswer();
    setState(() {
      if (quizBank.isFinished() == true)
      {
        check=false;
        _timer!.cancel();
        quizBank.reset();
        _scorekeeper = [];
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

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Resultpage(att: attempt, unatt: unattempt, right: right, wronge: wronge, total: 14)));},
              width: 120,
            ),
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Quiz1page()));},
              width: 120,
            )
          ],
        ).show();
        quizBank.reset();
        _counter=20;
        questionnumber=1;



      }
      else
        {
        if (questionAnswer == userAnswer)
        {
          right=right+1;
          remaining=remaining-1;
          attempt=attempt+1;
          unattempt=unattempt-1;
          _scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        }
        else
          {
          attempt=attempt+1;
          wronge=wronge+1;
          unattempt=unattempt-1;
          remaining=remaining-1;
          _scorekeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBank.nextQuestion();
        questionnumber = questionnumber + 1;
        _counter=20;
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
            quizBank.reset();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Resultpage(att: attempt, unatt: unattempt, right: right, wronge: wronge, total: 14)));
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
              title: Text("Total Question:14"),
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
                  child: Text("$_counter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.lightBlue
                  ,
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Question#$questionnumber/14",
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
                          quizBank.getQuestionText()!,
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if(check==true)
                          {
                            checkAnswer(true);
                          }

                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if(check==true)
                          {
                            checkAnswer(false);
                          }

                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      child: Text(
                        'False',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: _scorekeeper,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
