import 'package:compass/Screen/Compass%20rose.dart';
import 'package:compass/Screen/Compass.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Location Finder"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png",),
              alignment: Alignment.topCenter,
              scale: 2.5
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Row(
              children: [
                CustomCard(
                  title: 'Compass',
                  image: 'assets/b.png',
                  voidCallback: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Compass()));
                  },
                ),
                CustomCard(
                  title: 'Compass Ross',
                  image: 'assets/a.png',
                  voidCallback: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CompassRoss()));
                  },
                ),

              ],
            ),
            Row(
              children: [
                CustomCard(
                  title: 'Location',
                  image: 'assets/loc.png',
                  voidCallback: (){},
                ),
                CustomCard(
                  title: 'More',
                  image: 'assets/m.png',
                  voidCallback: (){},
                ),

              ],
            ),
            SizedBox(
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({required this.image,required this.title,required this.voidCallback});
  final String image;
  final String title;
  final VoidCallback voidCallback;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: voidCallback,
          child: Container(
            height: 150,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(image,scale: 3.1,),
                Text(title,style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}