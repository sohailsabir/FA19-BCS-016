import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

class ViewFees extends StatefulWidget {
  const ViewFees({Key? key}) : super(key: key);

  @override
  _ViewFeesState createState() => _ViewFeesState();
}

class _ViewFeesState extends State<ViewFees> {
  bool searchSate = false;
  String sname = "";

  Stream<QuerySnapshot>getUserData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('fees').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: !searchSate
            ? Text("View Fees")
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
                if(snapshot.data.docs[index]['name'].toString().toLowerCase().startsWith(sname.toLowerCase())){
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
    TextEditingController cname=new TextEditingController(text: snapshot.docs[index]['name']);
    TextEditingController fees=new TextEditingController(text: snapshot.docs[index]['fees']);
    var docid=snapshot.docs[index].id;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 25.0,
            child: Text("${snapshot.docs[index]['name'][0].toString().toUpperCase()}",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${snapshot.docs[index]['name']}"),
              Text("RS: ${snapshot.docs[index]['fees']}"),
              Row(
                children: [
                  IconButton(onPressed: ()async{
                    await showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Update Class fees"),
                        content: Column(
                          children: [
                            TextField(
                              controller: cname,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.class__outlined,
                                    color: Colors.deepPurple,
                                  )),
                            ),
                            TextField(
                              controller: fees,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.monetization_on,
                                    color: Colors.deepPurple,
                                  )),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel",style: TextStyle(color: Colors.red),),),
                          TextButton(onPressed: ()async{
                            final uid=await getUserId();
                            if(cname.text.isNotEmpty){
                              FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('fees').doc(docid).update({
                                'name':cname.text,
                                'fees':fees.text,
                              });
                                Navigator.pop(context);

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
                                  final uid=await getUserId();
                                  Navigator.pop(context);


                                  var FirebaseReference=FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection("fees");
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

