import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Myapp(),
  ));
}

class Myapp extends StatelessWidget {
final player=AudioCache();
void playSound(String filename)
{
  player.play('$filename');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          pianobutton(
            string: "A5",
              onMainKeyPress: (){
                playSound('A5.mp3');

              }

              ),
          pianobuttonblack(
              onSuperKeyPress: (){
                playSound('B6.mp3');
              },
              onMainKeyPress: (){
                playSound('B5.mp3');
              },
            string: "B5",
              ),
          pianobuttonblack(
            onSuperKeyPress: (){
              playSound('E6.mp3');
            },
            onMainKeyPress: (){
              playSound('E5.mp3');
            },
            string: "E5",
          ),
          pianobuttonblack(
            onSuperKeyPress: (){
              playSound('F6.mp3');
            },
            onMainKeyPress: (){
              playSound('F5.mp3');
            },
            string: "F5",
          ),
          pianobutton(
            onMainKeyPress: (){
              playSound('E5.mp3');
            },
            string: "E5",
          ),
          pianobuttonblack(
            onSuperKeyPress: (){
              playSound('D6.mp3');
            },
            onMainKeyPress: (){
              playSound('D5.mp3');
            },
            string: "D5",
          ),
          pianobuttonblack(
            onSuperKeyPress: (){
              playSound('C6.mp3');
            },
            onMainKeyPress: (){
              playSound('C5.mp3');
            },
            string: "C5",
          ),

        ],
      ),
    );
  }
}

class pianobuttonblack extends StatelessWidget {
  pianobuttonblack({required this.onMainKeyPress,required this.onSuperKeyPress,required this.string});
  final VoidCallback onMainKeyPress;
final VoidCallback onSuperKeyPress;
final string;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        clipBehavior: Clip.none, children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0,top: 2.0,bottom: 2.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: ElevatedButton(onPressed: onMainKeyPress, child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  string,style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 30,
                  color: Colors.black26,

                ),
                  textAlign: TextAlign.right,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              ),
            ),
          ),
          Positioned(
            top: -22.0,
            child: Container(
            width: 250.0,
            height: 45.0,
            child: ElevatedButton(
              onPressed: onSuperKeyPress,
              child: null,
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
class pianobutton extends StatelessWidget {
  pianobutton({required this.onMainKeyPress,required this.string});
  final VoidCallback onMainKeyPress;
  final string;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0,top: 2.0,bottom: 2.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ElevatedButton(onPressed: onMainKeyPress, child: Align(
            alignment: Alignment.centerRight,
            child: Text(string,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black26,

              ),),
          ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
