
import 'dart:math';

import 'package:bmicalculator/Brain/calculator.dart';
import 'package:bmicalculator/resultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/roundButton.dart';
import 'components/repeat_container.dart';
import 'components/text_and_Icon.dart';
import 'contants/contantsfile.dart';
int GuessNum=25;
int MAX=60;
int MIN=10;

enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}


class _InputPageState extends State<InputPage> {
int maxValue=100;
int minValue=1;
bool? selectedtype;

  Gender? selectGender;
  // Color maleColor=deActiveColor;
  // Color feMaleColor=deActiveColor;
  // void selectGender(Gender gender)
  // {
  //   if(gender==Gender.male)
  //     {
  //       maleColor=activeColor;
  //       feMaleColor=deActiveColor;
  //     }
  //   if(gender==Gender.female)
  //   {
  //     maleColor=deActiveColor;
  //     feMaleColor=activeColor;
  //   }
  //
  // }

  //check easy and tough
void check(int userselect)
{
  if(userselect==1)
    {
      selectedtype=true;
      GuessNum=(minValue+Random().nextInt(maxValue-minValue));
    }
  if(userselect==2)
    {
      selectedtype=false;
      GuessNum=(minValue+Random().nextInt(maxValue-minValue));
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Guessing Game'),

          actions: [

            SpinKitSpinningLines(
          color: Color(0xFF41855A),
          size: 50.0,
        ),
            SpinKitSpinningLines(
              color: Color(0xFF41855A),
              size: 50.0,
            ),
            SpinKitSpinningLines(
              color: Color(0xFF41855A),
              size: 50.0,
            ),
            SpinKitSpinningLines(
              color: Color(0xFF41855A),
              size: 50.0,
            ),
            SpinKitSpinningLines(
              color: Color(0xFF41855A),
              size: 50.0,
            ),

          ],

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
              children: [
                Expanded(
                  child: RepeatContainer(
                    onpressed: (){
                      setState(() {
                        selectGender=Gender.male;
                        check(1);
                      });

                    },
                    colors: selectGender==Gender.male?activeColor:deActiveColor,
                    cardWidget: TextAndIcon(
                      icon: FontAwesomeIcons.arrowsSpin,
                      lable: 'EASY',
                    ),
                  ),),
                Expanded(
                  child: RepeatContainer(
                    onpressed: (){
                      setState(() {
                        selectGender=Gender.female;
                        check(2);
                      });

                    },
                    colors: selectGender==Gender.female?activeColor:deActiveColor,
                    cardWidget: TextAndIcon(
                      icon: FontAwesomeIcons.arrowsToCircle,
                      lable: 'TOUGH',
                    ),
                  ),),
              ],
            ),),
            Expanded(
              child: RepeatContainer(
              colors: Color(0xFF1D1E33),
                cardWidget: selectedtype==false?null:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("RANDOM NUMBER",
                    style: kLableStyle,),
                    Slider(
                      max: maxValue.toDouble(),
                        min: minValue.toDouble(),
                        activeColor: Color(0xFF41855A),
                        inactiveColor: Color(0xFF8D8E98),
                        value: GuessNum.toDouble(),
                        onChanged: (double newVlaue){
                      // setState(() {
                      //   sliderHeight=newVlaue.round();
                      // });
                    },
                    ),
                  ],
                ),
            ),),
            Expanded(
              child: Row(
              children: [
                Expanded(
                  child: RepeatContainer(
                    colors: Color(0xFF1D1E33),
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("MAX",
                          style: kLableStyle,),
                        Text(
                          MAX.toString(),
                          style: kNumStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                                icon: FontAwesomeIcons.arrowUp,
                                onPressed:(){
                                  setState(() {
                                    MAX=(minValue+Random().nextInt(maxValue-minValue));
                                  });
                                },
                            ),

                          ],
                        ),
                      ],
                    ),

                ),),
                Expanded(
                  child:RepeatContainer(
                  colors: Color(0xFF1D1E33),
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("MIN",
                          style: kLableStyle,),
                        Text(
                          MIN.toString(),
                          style: kNumStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                                icon: FontAwesomeIcons.arrowDown,
                                onPressed: (){
                                  setState(() {
                                    MIN=(minValue+Random().nextInt(maxValue-minValue));
                                  });
                                }),


                          ],
                        ),
                      ],
                    ),
                ),),
              ],
            ),),
            GestureDetector(
              onTap: (){
                GuessCalculator Guess=GuessCalculator(GussNum: GuessNum,maxNum: MAX,minNum: MIN);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen(ExactNum: Guess.ExactNumber(),ResultText: Guess.GetResultText()),),);
              },
              child: Container(
                child: Center(
                  child: Text('Check',style: kLargeButtonStyle,),
                ),
                color: Color(0xFF41855A),
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 70.0,
              ),
            ),

          ],
        )
    );
  }
}

