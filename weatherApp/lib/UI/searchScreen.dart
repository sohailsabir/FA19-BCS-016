import 'package:flutter/material.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search City"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/white_snow.png'),
              height: 590,
              width: 500,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: [
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    labelText: 'Please Enter City Name',
                    border: UnderlineInputBorder(),
                  ),

                ),
              ),
              ListTile(
                title: TextButton(
                  onPressed: (){},
                  child: Text("Search"),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    backgroundColor: Colors.deepOrange.shade200
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
