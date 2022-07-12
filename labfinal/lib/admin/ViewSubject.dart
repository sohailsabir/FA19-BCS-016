import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

class ViewSubject extends StatefulWidget {
  const ViewSubject({Key? key}) : super(key: key);

  @override
  _ViewSubjectState createState() => _ViewSubjectState();
}

class _ViewSubjectState extends State<ViewSubject> {
  bool searchSate = false;
  String sname = "";

  Stream<QuerySnapshot>getUserData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('subjects').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: !searchSate
            ? Text("View Subject")
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
                if(snapshot.data.docs[index]['sname'].toString().toLowerCase().startsWith(sname.toLowerCase())){
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
    TextEditingController cname=new TextEditingController(text: snapshot.docs[index]['sname']);
    var docid=snapshot.docs[index].id;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 25.0,
            child: Text("${snapshot.docs[index]['sname'][0]}",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${snapshot.docs[index]['sname']}"),
              Row(
                children: [
                  IconButton(onPressed: ()async{
                    await showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Update Subject name"),
                        content: TextField(
                          controller: cname,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.class__outlined,
                                color: Colors.deepPurple,
                              )),
                        ),
                        actions: [
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel",style: TextStyle(color: Colors.red),),),
                          TextButton(onPressed: ()async{
                            final uid=await getUserId();
                            if(cname.text.isNotEmpty){
                              FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('subjects').doc(docid).update({
                                'sname':cname.text
                              }).then((value){
                                Navigator.pop(context);
                              });
                            }
                          }, child: Text("Update",style: TextStyle(color: Colors.deepPurple),),),
                        ],
                      );
                    });
                  }, icon: Icon(Icons.edit,color: Colors.purple,)),
                  IconButton(onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final uid=await getUserId();
                                  Navigator.pop(context);


                                  var FirebaseReference=FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection("subjects");
                                  await FirebaseReference.doc(docid).delete();


                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            ],
                          );
                        });
                  }, icon: Icon(Icons.delete_forever_sharp,color: Colors.red,)),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

