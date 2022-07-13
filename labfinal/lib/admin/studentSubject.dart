import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/admin/AddStudentSubject.dart';

import '../Authentication/firebaseAuthentication.dart';
import '../Component/Loading.dart';

class StudentSubject extends StatefulWidget {
  const StudentSubject({Key? key}) : super(key: key);

  @override
  _StudentSubjectState createState() => _StudentSubjectState();
}

class _StudentSubjectState extends State<StudentSubject> {
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
            ? Text("Select Student")
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
class CustomCard extends StatelessWidget {
  CustomCard({required this.snapshot,required this.index});
  final int index;
  final QuerySnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final docid=snapshot.docs[index].id;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudentSubject(docid: docid)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(snapshot.docs[index]['name']),
            leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.docs[index]['img']),
            backgroundColor: Colors.grey),
          ),
        ),
      ),
    );
  }
}
