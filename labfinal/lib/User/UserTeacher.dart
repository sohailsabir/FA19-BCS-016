import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/User/Notification.dart';


import '../Component/Loading.dart';

class UserTeacherPage extends StatefulWidget {
  UserTeacherPage({required this.StudentID});
  final String StudentID;

  @override
  _UserTeacherPageState createState() => _UserTeacherPageState();
}

class _UserTeacherPageState extends State<UserTeacherPage> {
  // String name="";
  // String img="";
  // String fees="";
  // String sclass="";
  // String phone="";
  // Future getUserData()async{
  //   try{
  //     DocumentSnapshot sn=await FirebaseFirestore.instance.collection('student').doc(widget.StudentID).get();
  //     name=sn.get('name');
  //     img=sn.get('password');
  //     fees=sn.get('fees');
  //     sclass=sn.get('class');
  //     String phone=sn.get('phone');
  //
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //
  //   }
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUserData();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Mode"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNotificationPage()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('teacher').doc(widget.StudentID).snapshots(),
          builder: ( context,AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
            {
              return Center(
                child: saveloading,
              );

            }
            else{
              var document=snapshot.data;
              return Container(
                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(

                      child: Stack(
                        children: [
                          Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                            ),
                          ),
                          FractionalTranslation(
                            translation: Offset(0.0, 0.4),
                            child: Align(
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.grey,

                                child: CircleAvatar(
                                  radius: 55.0,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      document['img']),
                                ),
                              ),
                              alignment: FractionalOffset(0.5, 0.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(

                        children: [
                          Row(
                            children: [
                              Text("FULL NAME:  ", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                              Text(
                                document['tname'].toString().toUpperCase(),style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("PHONE:  ", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                              Text(
                                document['tphone'].toString().toLowerCase(),style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("CLASS:  ", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                              Text(document['tclass']
                                  .toString()
                                  .toUpperCase(),style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("Subject:  ", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                              Text(document['tsubject']
                                  .toString()
                                  .toUpperCase(),style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text("PASSWORD:  ", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                              Text(document['pas']
                                  .toString()
                                  ,style: TextStyle(fontSize: 18),),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),


                        ],
                      ),
                    ),


                  ],
                ),
              );

            }

          }


      ),


    );
  }
}
class CustomCard extends StatefulWidget {
  CustomCard({required this.snapshot, required this.index});

  final QuerySnapshot snapshot;
  final int index;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
    final docid = widget.snapshot.docs[widget.index].id;
    String urlimg=widget.snapshot.docs[widget.index]['img'];
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(

            child: Stack(
              children: [
                Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
                FractionalTranslation(
                  translation: Offset(0.0, 0.4),
                  child: Align(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,

                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            widget.snapshot.docs[widget.index]['img']),
                      ),
                    ),
                    alignment: FractionalOffset(0.5, 0.0),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("FULL NAME:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(
                      widget.snapshot.docs[widget.index]['name'].toString().toUpperCase(),),
                  ],
                ),
                Row(
                  children: [
                    Text("PHONE:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(
                      widget.snapshot.docs[widget.index]['phone'].toString().toLowerCase(),),
                  ],
                ),
                Row(
                  children: [
                    Text("CLASS:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['class']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("FEES:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['fees']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("PASSWORD:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['password']
                        .toString()
                        .toUpperCase()),
                  ],
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
