
import 'package:bmicalculator/resultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/repeat_container.dart';
import 'components/text_and_Icon.dart';
import 'contants/contantsfile.dart';
int sliderHeight=180;
int weight=60;
int age=20;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
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
                      });

                    },
                    colors: selectGender==Gender.male?activeColor:deActiveColor,
                    cardWidget: TextAndIcon(
                      icon: FontAwesomeIcons.person,
                      lable: 'Male',
                    ),
                  ),),
                Expanded(
                  child: RepeatContainer(
                    onpressed: (){
                      setState(() {
                        selectGender=Gender.female;
                      });

                    },
                    colors: selectGender==Gender.female?activeColor:deActiveColor,
                    cardWidget: TextAndIcon(
                      icon: FontAwesomeIcons.personDress,
                      lable: 'Female',
                    ),
                  ),),
              ],
            ),),
            Expanded(
              child: RepeatContainer(
              colors: Color(0xFF1D1E33),
                cardWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HEIGHT",
                    style: kLableStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(sliderHeight.toString(),
                          style:kNumStyle,
                          ),
                        Text(
                          "cm",style: kLableStyle,)
                      ],
                    ),
                    Slider(
                      max: 220.0,
                        min: 120,
                        activeColor: Color(0xFF41855A),
                        inactiveColor: Color(0xFF8D8E98),
                        value: sliderHeight.toDouble(), onChanged: (double newVlaue){
                      setState(() {
                        sliderHeight=newVlaue.round();
                      });
                    })
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
                        Text("WEIGHT",
                          style: kLableStyle,),
                        Text(
                          weight.toString(),
                          style: kNumStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: (){
                                  setState(() {
                                    weight--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: (){
                                  setState(() {
                                    weight++;
                                  });
                                }),

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
                        Text("AGE",
                          style: kLableStyle,),
                        Text(
                          age.toString(),
                          style: kNumStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: (){
                                  setState(() {
                                    age--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: (){
                                  setState(() {
                                    age++;
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen()));
              },
              child: Container(
                child: Center(
                  child: Text('Calculate',style: kLargeButtonStyle,),
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
class RoundButton extends StatelessWidget {
  RoundButton({required this.icon,required this.onPressed});
final IconData icon;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(onPressed: onPressed,
    child: Icon(icon),
    constraints: BoxConstraints.tightFor(
      height: 46.0,
      width: 46.0,
    ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),

    );
  }
}
