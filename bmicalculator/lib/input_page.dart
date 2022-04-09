
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/repeat_container.dart';
import 'components/text_and_Icon.dart';
const activeColor=Color(0xFF1D1E33);
const deActiveColor=Color(0xFF111328);
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
          children: [
            Expanded(
              child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectGender=Gender.male;
                    });
                  },
                  child: RepeatContainer(
                    colors: selectGender==Gender.male?activeColor:deActiveColor,
                    cardWidget: TextAndIcon(
                      icon: FontAwesomeIcons.person,
                      lable: 'Male',
                    ),
                  ),
                ),),
                Expanded(
                  child: GestureDetector(
                  onTap: (){

                    setState(() {
                      selectGender=Gender.female;
                    });
                  },
                  child: RepeatContainer(
                    colors: selectGender==Gender.female?activeColor:deActiveColor,
                    cardWidget: TextAndIcon(
                      icon: FontAwesomeIcons.personDress,
                      lable: 'Female',
                    ),
                  ),
                ),),
              ],
            ),),
            Expanded(
              child: RepeatContainer(
              colors: Color(0xFF1D1E33),
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