
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/repeat_container.dart';
import 'components/text_and_Icon.dart';
const activeColor=Color(0xFF1D1E33);
const deActiveColor=Color(0xFF111328);

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}


class _InputPageState extends State<InputPage> {
  Color maleColor=deActiveColor;
  Color feMaleColor=deActiveColor;
  void selectGender(int gender)
  {
    if(gender==1)
      {
        maleColor=activeColor;
        feMaleColor=deActiveColor;
      }
    if(gender==2)
    {
      maleColor=deActiveColor;
      feMaleColor=activeColor;
    }

  }

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
                      selectGender(1);
                    });
                  },
                  child: RepeatContainer(
                    colors: maleColor,
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
                      selectGender(2);
                    });
                  },
                  child: RepeatContainer(
                    colors: feMaleColor,
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