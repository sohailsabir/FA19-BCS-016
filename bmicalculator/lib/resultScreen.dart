import 'package:bmicalculator/components/repeat_container.dart';
import 'package:bmicalculator/contants/contantsfile.dart';
import 'package:flutter/material.dart';
class ResultScreen extends StatelessWidget {
  ResultScreen({this.BMINum,this.BMIText,this.Interpretation});
final String? BMIText;
final String? BMINum;
final String? Interpretation;
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
                  Text(BMIText!,
                  style: kResultStyle,),
                  Text(BMINum!,
                  style: kNumS2,),
                  Text(Interpretation!,
                  style: kTextStyleS2,
                  textAlign: TextAlign.center,),
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
          ),),

        ],
      ),
    );
  }
}
