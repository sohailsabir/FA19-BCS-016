import 'package:flutter/material.dart';
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
              ),),
              Expanded(child: RepeatContainer(
                colors: Color(0xFF1D1E33),
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

class RepeatContainer extends StatelessWidget {
  RepeatContainer({required this.colors});
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}


