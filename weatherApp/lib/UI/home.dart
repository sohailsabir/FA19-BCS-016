import 'package:flutter/material.dart';
class Climate extends StatefulWidget {
  const Climate({Key? key}) : super(key: key);

  @override
  _ClimateState createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(
            Icons.search,
          ))
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/umbrella.png'),
              height: 590,
              width: 500,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Text("Vehari",style: kCityStyle,),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 15.0,left: 20.0),

          ),
          Container(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage("assets/light_rain.png"),

            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 150.0, 0.0, 0.0),
            alignment: Alignment.centerLeft,
            child: Text("67.8F",style: kTemStyle,),
          )
        ],
      ),
    );
  }
}
const kCityStyle=TextStyle(
  fontSize: 25.0,
  color: Colors.white,
  fontWeight: FontWeight.bold
);
const kTemStyle=TextStyle(
  color:Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 49.0,
);