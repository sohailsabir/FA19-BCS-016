import 'package:bmicalculator/components/repeat_container.dart';
import 'package:bmicalculator/contants/contantsfile.dart';
import 'package:flutter/material.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Result"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
            child: Text("Your Result",
            style: kTitleS2,),
          ),),
          Expanded(
            flex: 5,
            child: RepeatContainer(
            colors: activeColor,
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Normal",
                  style: kResultStyle,),
                  Text('18.0',
                  style: kNumS2,),
                  Text("This is the Interpretation of BMI Calculator",
                  style: kTextStyleS2,),
                ],
              ),
          ),),
          Expanded(child: GestureDetector(
            onTap: (){
             Navigator.pop(context);
            },
            child: Container(
              child: Center(
                child: Text('Recalculate',style: kLargeButtonStyle,),
              ),
              color: Color(0xFF41855A),
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 70.0,
            ),
          ),)

        ],
      ),
    );
  }
}
