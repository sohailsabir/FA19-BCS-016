import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    final docid = snapshot.docs[index].id;
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
                        backgroundImage: NetworkImage(
                            snapshot.docs[index]['img']),
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
                      snapshot.docs[index]['tname'].toString().toUpperCase(),),
                  ],
                ),
                Row(
                  children: [
                    Text("Email:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(
                      snapshot.docs[index]['temail'].toString().toLowerCase(),),
                  ],
                ),
                Row(
                  children: [
                    Text("PHONE NO:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(snapshot.docs[index]['tphone']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("Class:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(snapshot.docs[index]['tclass']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("SUBJECT:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(snapshot.docs[index]['tsubject']
                        .toString()
                        .toUpperCase()),
                  ],
                ),
                Row(
                  children: [
                    Text("PASSWORD:  ", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(snapshot.docs[index]['pas']),
                  ],
                ),


              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {

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

  static void deleteFireBaseStorageItem(String fileUrl) {
    String filePath = fileUrl
        .replaceAll(new
    RegExp(
        r'https://firebasestorage.googleapis.com/v0/b/dial-in-2345.appspot.com/o/'),
        '');

    filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');

    filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');

    var storageReferance = FirebaseStorage.instance.ref();

    storageReferance.child(filePath).delete().then((_) =>
        print('Successfully deleted $filePath storage item'));
  }
}








