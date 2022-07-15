import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

class ViewStudentSubject extends StatefulWidget {
  ViewStudentSubject({required this.studentid,required this.Studentname});
  final String studentid;
  final String Studentname;

  @override
  _ViewStudentSubjectState createState() => _ViewStudentSubjectState();
}

class _ViewStudentSubjectState extends State<ViewStudentSubject> {
  bool searchSate = false;
  String sname = "";

  Stream<QuerySnapshot>getUserData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('student').doc(widget.studentid).collection('studentsubject').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: !searchSate
            ? Text("Student Subject")
            : TextField(
          cursorColor: Colors.white,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration:  InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
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
        builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData)return Center(child: saveloading,);
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,int index){
                if(sname.isEmpty){
                  return CustomCard(
                    index: index,
                    snapshot: snapshot.data,
                    Studentname: widget.Studentname,
                  );
                }
                if(snapshot.data.docs[index]['name'].toString().toLowerCase().startsWith(sname.toLowerCase())){
                  return CustomCard(
                    index: index,
                    snapshot: snapshot.data,
                    Studentname: widget.Studentname,
                  );
                }
                else{
                  return Container();
                }
              });
        },
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({required this.snapshot,required this.index,required this.Studentname});
  final QuerySnapshot snapshot;
  final int index;
  final String Studentname;

  @override
  Widget build(BuildContext context) {
    TextEditingController cname=new TextEditingController(text: snapshot.docs[index]['name']);
    var docid=snapshot.docs[index].id;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          title: Column(
            children: [
              Row(
                children: [
                  Text("Student name:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${Studentname}"),
                ],
              ),
              Row(
                children: [
                  Text("Student Subject:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${snapshot.docs[index]['name']}"),



                ],
              ),
              Row(
                children: [
                  Text("Teacher:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${snapshot.docs[index]['teacher']}"),



                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

