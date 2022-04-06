import 'package:flutter/material.dart';
import 'package:quizapp/Screens/dashboard.dart';
class Resultpage extends StatelessWidget {
  Resultpage({required this.att,required this.unatt,required this.right, required this.wronge,required this.total});
  final int att;
  final int unatt;
  final int right;
  final int wronge;
  final int total;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Question:$total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),),

                         Text("Attempted Question:$att",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20.0,
                           ),),
                         Text("Unattempted Question:$unatt",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20.0,
                           ),),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Text(
                               "Right:$right",style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20.0,
                             ),),
                             Text(
                               "Wrong:$wronge",style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20.0,
                             ),),
                           ],
                         ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
