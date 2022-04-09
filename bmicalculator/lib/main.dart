import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main(){
  runApp(BMICalculator());
}
class BMICalculator extends StatelessWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: InputPage(),
    );
  }
}
class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Expanded(child: Row(
            children: [
              Expanded(child: RepeatContainer(
                colors: Color(0xFF1D1E33),
                cardWidget: TextAndIcon(
                  icon: FontAwesomeIcons.person,
                  lable: 'Male',
                ),
              ),),
              Expanded(child: RepeatContainer(
                colors: Color(0xFF1D1E33),
                cardWidget: TextAndIcon(
                  icon: FontAwesomeIcons.personDress,
                  lable: 'Female',
                ),
              ),),
            ],
          ),),
          Expanded(child: RepeatContainer(
            colors: Color(0xFF1D1E33),
          ),),
          Expanded(child: Row(
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

class TextAndIcon extends StatelessWidget {
  TextAndIcon({required this.icon,required this.lable});
final IconData icon;
final String lable;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Icon(
            icon,
            size: 40.0,
          ),
          SizedBox(
            height: 13.0,
          ),
          Text(lable,
            style: TextStyle(
            color: Color(0xFF8D8E98),
            fontSize: 18,
          ),)
      ],
    );
  }
}

class RepeatContainer extends StatelessWidget {
  RepeatContainer({required this.colors,this.cardWidget});
  final Color colors;
  final Widget? cardWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardWidget,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}


