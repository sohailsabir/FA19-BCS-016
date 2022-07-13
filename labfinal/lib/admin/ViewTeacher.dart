import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:labfinal/admin/UpdateTeacherRecord.dart';

class ViewTeacher extends StatefulWidget {
  const ViewTeacher({Key? key}) : super(key: key);

  @override
  _ViewTeacherState createState() => _ViewTeacherState();
}

class _ViewTeacherState extends State<ViewTeacher> {
  bool searchSate = false;
  String tname = "";

  Stream<QuerySnapshot> getUserData() async* {
    final uid = await getUserId();
    yield* FirebaseFirestore.instance
        .collection('Acedemy')
        .doc(uid)
        .collection('teacher')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: !searchSate
            ? Text("View Teacher")
            : TextField(
                cursorColor: Colors.white,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Search here...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  setState(() {
                    tname = value;
                  });
                },
              ),
        actions: [
          !searchSate
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchSate = !searchSate;
                    });
                  },
                  icon: Icon(Icons.search),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searchSate = !searchSate;
                    });
                  },
                  icon: Icon(Icons.cancel)),
        ],
      ),
      body: StreamBuilder(
        stream: getUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: saveloading,
            );
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index) {
                if (tname.isEmpty) {
                  return CustomCard(
                    index: index,
                    snapshot: snapshot.data,
                  );
                }
                if (snapshot.data.docs[index]['tname']
                    .toString()
                    .toLowerCase()
                    .startsWith(tname.toLowerCase())) {
                  return CustomCard(
                    index: index,
                    snapshot: snapshot.data,
                  );
                } else {
                  return Container();
                }
              });
        },
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
    TextEditingController tname= TextEditingController(text: widget.snapshot.docs[widget.index]['tname']);
    TextEditingController temail= TextEditingController(text: widget.snapshot.docs[widget.index]['temail']);
    TextEditingController tphone= TextEditingController(text: widget.snapshot.docs[widget.index]['tphone']);
    TextEditingController tclass= TextEditingController(text: widget.snapshot.docs[widget.index]['tclass']);
    TextEditingController tsubject=TextEditingController(text: widget.snapshot.docs[widget.index]['tsubject']);
    TextEditingController tpass=TextEditingController(text: widget.snapshot.docs[widget.index]['pas']);
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
                      widget.snapshot.docs[widget.index]['tname'].toString().toUpperCase(),),
                  ],
                ),
                Row(
                  children: [
                    Text("Email:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(
                      widget.snapshot.docs[widget.index]['temail'].toString().toLowerCase(),),
                  ],
                ),
                Row(
                  children: [
                    Text("PHONE NO:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['tphone']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("Class:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['tclass']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("SUBJECT:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['tsubject']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("PASSWORD:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(widget.snapshot.docs[widget.index]['pas']),
                  ],
                ),


              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async{
                  await showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Update Teacher Infomation"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tname,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: temail,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tphone,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.phone,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tpass,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    icon: Icon(
                                      Icons.password,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tclass,
                                decoration: InputDecoration(
                                    hintText: 'class',
                                    icon: Icon(
                                      Icons.class__rounded,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tsubject,
                                decoration: InputDecoration(
                                  hintText: 'subject',
                                    icon: Icon(
                                      Icons.subject,
                                      color: Colors.deepPurple,
                                    )),
                              ),
                            ),

                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel",style: TextStyle(color: Colors.red),),),
                        TextButton(onPressed: ()async{
                          final uid=await getUserId();
                          if(tname.text.isNotEmpty&&tsubject.text.isNotEmpty&&tpass.text.isNotEmpty&&tclass.text.isNotEmpty&&tphone.text.isNotEmpty&&temail.text.isNotEmpty){
                            FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('teacher').doc(docid).update({
                              'tname':tname.text,
                              'temail':temail.text,
                              'tphone':temail.text,
                              'tsubject':tsubject.text,
                              'pas':tpass.text,
                              'tclass':tclass.text
                            }).then((value){
                              Navigator.pop(context);
                            });
                          }
                        }, child: Text("Update",style: TextStyle(color: Colors.deepPurple),),),
                      ],
                    );
                  });

                },
                child: Text("EDIT"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Are you sure?'),
                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            print(urlimg);
                           final uid = await getUserId();
                            Navigator.pop(context);
                            var FirebaseReference = FirebaseFirestore.instance
                                .collection('Acedemy').doc(uid).collection(
                                "teacher");
                            await FirebaseReference.doc(docid).delete();

                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],

                    );
                  });
                },
                child: Text("DELETE"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,

                ),
              ),
              SizedBox(width: 10,),
            ],
          )


        ],
      ),
    );
  }
}








