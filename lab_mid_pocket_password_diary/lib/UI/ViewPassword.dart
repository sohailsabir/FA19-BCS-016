import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewPasswordScreen extends StatefulWidget {
  const ViewPasswordScreen({Key? key}) : super(key: key);

  @override
  _ViewPasswordScreenState createState() => _ViewPasswordScreenState();
}

class _ViewPasswordScreenState extends State<ViewPasswordScreen> {
  var firebaseDB=FirebaseFirestore.instance.collection("PasswordBD").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Password"),
        backgroundColor: Colors.pink,
      ),
      body: StreamBuilder(
        stream: firebaseDB,
        builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData)return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index)
          {
            return CustomCard(snapshot: snapshot.data, index: index);
            // return Card(
            //       elevation: 6.0,
            //       child: Column(
            //         children: [
            //           ListTile(
            //             leading: CircleAvatar(
            //               backgroundColor: Colors.pink.shade300,
            //               radius: 25.0,
            //               child: Text("${snapshot.data.docs[index]['name'][0]}"),
            //             ),
            //             title: Text("${snapshot.data.docs[index]['name']}",style: TextStyle(
            //               fontWeight: FontWeight.w500
            //             ),),
            //             subtitle: Text("${snapshot.data.docs[index]['password']}"),
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               IconButton(
            //                 onPressed: ()async{
            //                 await showDialog(
            //                   context: context,
            //                   builder: (BuildContext context) {
            //                     return AlertDialog(
            //                       title: Text('Update Password'),
            //                       content: TextField(
            //                         //controller: pass,
            //                         decoration: InputDecoration(
            //                             icon: Icon(
            //                               Icons.password,
            //                               color: Colors.pink,
            //                             )
            //                         ),
            //                       ),
            //                       actions: [
            //                         TextButton(
            //                           onPressed: () {
            //                             Navigator.of(context).pop();
            //                           },
            //                           child: Text('Update', style: TextStyle(color: Colors.pink),),
            //                         ),
            //                         TextButton(
            //                           onPressed: () {
            //                             Navigator.of(context).pop();
            //                           },
            //                           child: Text('Cancel', style: TextStyle(color: Colors.pink),),
            //                         ),
            //                       ],
            //                     );
            //                   },
            //                 );
            //               }, icon: Icon(
            //                 Icons.edit,
            //                 color: Colors.pink,
            //               ),),
            //               IconButton(onPressed: (){}, icon: Icon(
            //                 Icons.delete,
            //                 color: Colors.pink,
            //               ),),
            //             ],
            //           )
            //         ],
            //       ),
            //     );
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
    
    var docId=snapshot.docs[index].id;
    TextEditingController pass=new TextEditingController(text: snapshot.docs[index]['password']);
    return Card(
      elevation: 6.0,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink.shade300,
              radius: 25.0,
              child: Text("${snapshot.docs[index]['name'][0]}"),
            ),
            title: Text("${snapshot.docs[index]['name']}",style: TextStyle(
                fontWeight: FontWeight.w500
            ),),
            subtitle: Text("${snapshot.docs[index]['password']}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: ()async{
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Update Password'),
                        content: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.password,
                                color: Colors.pink,
                              )
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                             if(pass.text.isNotEmpty){
                               FirebaseFirestore.instance.collection('PasswordBD').doc(docId).update({
                                 "password":pass.text,
                               }).then((value) {
                                 Navigator.pop(context);
                               });
                             }
                            },
                            child: Text('Update', style: TextStyle(color: Colors.pink),),
                          ),
                          TextButton(
                            onPressed: (){

                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel', style: TextStyle(color: Colors.pink),),
                          ),
                        ],
                      );
                    },
                  );
                }, icon: Icon(
                Icons.edit,
                color: Colors.pink,
              ),),
              IconButton(onPressed: () async{
                  var FirebaseReference=FirebaseFirestore.instance.collection('PasswordBD');
                  await FirebaseReference.doc(docId).delete();

                },
               icon: Icon(
                Icons.delete,
                color: Colors.pink,
              ),),
            ],
          )
        ],
      ),
    );
  }
}



