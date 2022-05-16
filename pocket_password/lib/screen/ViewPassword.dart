

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewPasswordScreen extends StatefulWidget {
  const ViewPasswordScreen({Key? key}) : super(key: key);

  @override
  _ViewPasswordScreenState createState() => _ViewPasswordScreenState();
}

class _ViewPasswordScreenState extends State<ViewPasswordScreen> {
  var firebaseDB=FirebaseFirestore.instance.collection("PasswordBD").snapshots();
  bool eyeVisibily=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Password"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firebaseDB,
        builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData)return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index)
          {
            return CustomCard(
              snapshot: snapshot.data,
              index: index,
              icon: eyeVisibily?Icons.visibility_off:Icons.visibility,
              onpressed: (){
              setState(() {
                 eyeVisibily=!eyeVisibily;
              });
            },
            passvisibiliy: eyeVisibily,);

          });
        },
      ),
      );
  }
}
class CustomCard extends StatelessWidget {

  CustomCard({required this.snapshot,required this.index,required this.icon,required this.onpressed,required this.passvisibiliy});
  final QuerySnapshot snapshot;
  final int index;
  final IconData icon;
  final bool passvisibiliy;
  final VoidCallback onpressed;
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
              backgroundColor: Colors.blue.shade400,
              radius: 25.0,
              child: Text("${snapshot.docs[index]['name'][0]}",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${snapshot.docs[index]['name']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text(passvisibiliy?"**********":"${snapshot.docs[index]['password']}",
                      style: TextStyle(color: Colors.grey),),
                  ],
                ),
                IconButton(onPressed: onpressed, icon: Icon(
                    icon,),
                  iconSize: 30,
                  color: Colors.lightBlue,
                ),
                // Text("${snapshot.docs[index]['name']}",style: TextStyle(
                //     fontWeight: FontWeight.w500
                // ),),
              ],
            ),
            // subtitle: Text("${snapshot.docs[index]['password']}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.copy,color: Colors.lightBlue,),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.share,color: Colors.lightBlue,),
              ),
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
                                color: Colors.blue,
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
                            child: Text('Cancel', style: TextStyle(color: Colors.blue),),
                          ),
                        ],
                      );
                    },
                  );
                }, icon: Icon(
                Icons.edit,
                color: Colors.green,
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



