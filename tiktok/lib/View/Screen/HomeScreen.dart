import 'package:flutter/material.dart';
import 'package:tiktok/Component/Constants.dart';

import '../Widgets/CustomAddIcon.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageid=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        currentIndex: pageid,
        onTap: (index){
          setState(() {
            pageid=index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 25,),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 25,),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: customAddIcon(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined,size: 25,),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp,size: 25,),
            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: pageindex[pageid],
        ),
      ),
    );
  }
}
