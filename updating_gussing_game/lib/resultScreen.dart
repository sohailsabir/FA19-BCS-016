import 'package:bmicalculator/components/repeat_container.dart';
import 'package:bmicalculator/contants/contantsfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ResultScreen extends StatelessWidget {
  ResultScreen({this.ExactNum,this.ResultText});
final String? ResultText;
final String? ExactNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guessing Result"),
        actions: [

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
                  Text(ResultText!,
                  style: kResultStyle,),
                  Text(
                    "Exact Number",style:  kTextStyleS2,),

                  Text(ExactNum!,
                  style: kNumS2,),
                  SpinKitSpinningLines(
                    color: Color(0xFF41855A),
                    size: 50.0,
                  ),


                ],
              ),
          ),),
          Expanded(child: GestureDetector(
            onTap: (){
             Navigator.pop(context);
            },
            child: Container(
              child: Center(
                child: Text('Try Again',style: kLargeButtonStyle,),
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
