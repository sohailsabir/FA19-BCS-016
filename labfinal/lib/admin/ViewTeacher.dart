import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

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

class CustomCard extends StatelessWidget {
  CustomCard({required this.snapshot, required this.index});

  final QuerySnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(

        decoration: BoxDecoration(
          color: Colors.grey.shade300,

        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children:[
                  Card(
                    child: Container(
                      height: 120.0,
                      color: Colors.deepPurple,
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
                          backgroundImage: NetworkImage(snapshot.docs[index]['img']),
                        ),
                      ),
                      alignment: FractionalOffset(0.5, 0.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("FULL NAME:  "),
                Text(snapshot.docs[index]['tname'].toString().toUpperCase()),
              ],
            ),
            Row(
              children: [
                Text("Email:  "),
                Text(snapshot.docs[index]['temail'].toString().toLowerCase(),),
              ],
            ),
            Row(
              children: [
                Text("PHONE NO:  "),
                Text(snapshot.docs[index]['tphone'].toString().toUpperCase()),
              ],
            ),
            Row(
              children: [
                Text("Class:  "),
                Text(snapshot.docs[index]['tclass'].toString().toUpperCase()),
              ],
            ),
            Row(
              children: [
                Text("SUBJECT:  "),
                Text(snapshot.docs[index]['tsubject'].toString().toUpperCase()),
              ],
            ),
            Row(
              children: [
                Text("PASSWORD:  "),
                Text(snapshot.docs[index]['tsubject']),
              ],
            ),

          ],
        ),
      ),
    );
  }
}








