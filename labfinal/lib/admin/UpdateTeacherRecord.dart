
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Component/Loading.dart';

class UpdatePic extends StatefulWidget {
   UpdatePic({required this.docid}) ;
  final String docid;


  @override
  _UpdatePicState createState() => _UpdatePicState();
}

class _UpdatePicState extends State<UpdatePic> {
  Stream userimage()async*{
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(FirebaseAuth.instance.currentUser!.uid).collection('teacher').doc(widget.docid).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Update Picture"),
      ),
      body: StreamBuilder(
        stream: userimage(),
        builder: (context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(child: saveloading,);
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,int index){
              return  Center(
                child: CircleAvatar(
                    radius: 100,
                    child: CircleAvatar(radius: 95,)),
              );
            },
          );
        },
      ),

    );
  }
}

