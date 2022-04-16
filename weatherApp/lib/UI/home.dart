import 'package:flutter/material.dart';
import 'package:weatherapp/Utility/util.dart' as util;
import 'package:http/http.dart' as http;
import 'dart:convert';
class Climate extends StatefulWidget {
  const Climate({Key? key}) : super(key: key);

  @override
  _ClimateState createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  void ShowData()async{
    Map data=await getWeather(util.apiId, util.defaultCity);
    print(data.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            ShowData();
          }, icon: Icon(
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
  Future<Map> getWeather(String apiId,String city)async{
    String apiUrl="https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.apiId}";
    http.Response response=await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
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