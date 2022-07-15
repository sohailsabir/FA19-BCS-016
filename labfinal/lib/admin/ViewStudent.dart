import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:labfinal/admin/UpdateTeacherRecord.dart';

import 'ViewStudentSubject.dart';

class ViewStudent extends StatefulWidget {
  const ViewStudent({Key? key}) : super(key: key);

  @override
  _ViewStudentState createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  bool searchSate = false;
  String sname = "";

  Stream<QuerySnapshot> getUserData() async* {
    final uid = await getUserId();
    yield* FirebaseFirestore.instance
        .collection('Acedemy')
        .doc(uid)
        .collection('student')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: !searchSate
            ? Text("View Student")
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
              sname = value;
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
                if (sname.isEmpty) {
                  return CustomCard(
                    index: index,
                    snapshot: snapshot.data,
                  );
                }
                if (snapshot.data.docs[index]['name']
                    .toString()
                    .toLowerCase()
                    .startsWith(sname.toLowerCase())) {
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
    TextEditingController name= TextEditingController(text: widget.snapshot.docs[widget.index]['name']);
    TextEditingController phone= TextEditingController(text: widget.snapshot.docs[widget.index]['phone']);
    TextEditingController fees= TextEditingController(text: widget.snapshot.docs[widget.index]['fees']);
    TextEditingController password=TextEditingController(text: widget.snapshot.docs[widget.index]['password']);
    TextEditingController sclass=TextEditingController(text: widget.snapshot.docs[widget.index]['class']);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewStudentSubject(studentid: docid,Studentname: widget.snapshot.docs[widget.index]['name'],)));
                }, child: Text("View Subject"),),
              SizedBox(width: 20,),
              ElevatedButton(
                onPressed: () async{
                  await showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Update Student Infomation"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: name,
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
                                controller: phone,
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
                                controller: fees,
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
                                controller: password,
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
                                controller: sclass,
                                decoration: InputDecoration(
                                    hintText: 'class',
                                    icon: Icon(
                                      Icons.class__rounded,
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
                          if(name.text.isNotEmpty&&password.text.isNotEmpty&&sclass.text.isNotEmpty&&phone.text.isNotEmpty&&fees.text.isNotEmpty){
                            FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('student').doc(docid).update({
                              'name':name.text,
                              'phone':phone.text,
                              'fees':fees.text,
                              'password':password.text,
                              'class':sclass.text
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
                                "student");
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








