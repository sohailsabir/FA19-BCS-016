
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/repeat_container.dart';
import 'components/text_and_Icon.dart';
import 'contants/contantsfile.dart';

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
                    style: kLableStyle,)
                  ],
                ),
            ),),
            Expanded(
              child: Row(
              children: [
                Expanded(child: RepeatContainer(
                  colors: Color(0xFF1D1E33),
                ),),
                Expanded(child:RepeatContainer(
                  colors: Color(0xFF1D1E33),
                ),),
              ],
            ),),

          ],
        )
    );
  }
}