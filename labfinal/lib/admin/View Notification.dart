import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

class ViewNotification extends StatefulWidget {
  const ViewNotification({Key? key}) : super(key: key);

  @override
  _ViewNotificationState createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  bool searchSate = false;
  String sname = "";

  Stream<QuerySnapshot>getUserData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection('message').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: !searchSate
            ? Text("View Notication")
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
                  );
                }
                if(snapshot.data.docs[index]['title'].toString().toLowerCase().startsWith(sname.toLowerCase())){
                  return CustomCard(
                    index: index,
                    snapshot: snapshot.data,
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
  CustomCard({required this.snapshot,required this.index});
  final QuerySnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextEditingController title=new TextEditingController(text: snapshot.docs[index]['title']);
    TextEditingController body=new TextEditingController(text: snapshot.docs[index]['body']);

    var docid=snapshot.docs[index].id;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 25.0,
            child: Text("${snapshot.docs[index]['title'][0].toString().toUpperCase()}",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),),
          ),
          title: Text("${snapshot.docs[index]['title']}",textAlign: TextAlign.center,),
          subtitle: Text(snapshot.docs[index]['body'],textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

