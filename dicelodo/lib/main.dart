import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dialog_alert/dialog_alert.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int dice1 = 1;
  int player1=0;
  int player2=0;
  int player3=0;
  int player4=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text("Dice Roller App"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Image.asset("images/dice$dice1.png",width: 200.0,height: 200.0),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dice1 = Random().nextInt(6) + 1;
                        player1=player1+dice1;
                      });
                    },
                    child: Text("Player 1"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.amber,
                      onSurface: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dice1 = Random().nextInt(6) + 1;
                        player2=player2+dice1;
                      });
                    },
                    child: Text("Player 2"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.amber,
                      onSurface: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dice1 = Random().nextInt(6) + 1;
                        player3=player3+dice1;
                      });
                    },
                    child: Text("Player 3"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.amber,
                      onSurface: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dice1 = Random().nextInt(6) + 1;
                        player4=player4+dice1;
                      });
                    },
                    child: Text("Player 4"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.amber,
                      onSurface: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Player 1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Score:$player1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Player 2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Score:$player2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Player 3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Score:$player3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Player 4",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Score:$player4",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDialogAlert(
                      context: context,
                      title: 'Success',
                      message: 'You have successfully updated your profile.',
                      actionButtonTitle: 'OK',
                    );
                  },
                  child: const Text(
                    'Check Win',
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.amber,
                      textStyle:
                       TextStyle(fontSize: 24,),),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
