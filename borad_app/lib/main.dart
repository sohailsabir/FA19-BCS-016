import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fireStoreDB=FirebaseFirestore.instance.collection("board").snapshots();
  TextEditingController title=new TextEditingController();
  TextEditingController des=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chl Ja"),
      ),
body: StreamBuilder(
  stream: fireStoreDB,
  builder: (context,AsyncSnapshot snapshot){
    if(!snapshot.hasData) return CircularProgressIndicator();
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
        itemBuilder: (context,int index)
    {
      return Text(snapshot.data.docs[index]["title"]);
    });
  },
),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialog();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _showDialog() async{
    await showDialog(context: context, builder: (context)=>AlertDialog(
      contentPadding: EdgeInsets.all(10),
      title: Text("Enter Message Here"),
      content: Column(
        children: [
          Expanded(child: TextField(
            autofocus: true,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: 'Title',
              labelText: "Title",

            ),
            controller: title,

          ),),
          Expanded(child: TextField(
            autofocus: true,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: 'description',
              labelText: "description",

            ),
            controller: des,

          ),),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          title.clear();
          des.clear();
          Navigator.pop(context);
        }, child: Text("Cancel")),
        ElevatedButton(onPressed: (){
        FirebaseFirestore.instance.collection('board').add({
          "title":title.text,
          "description":des.text,
          "timeStamp":DateTime.now(),
        }).then((value) {
          print(value.id);
          title.clear();
          des.clear();
          Navigator.pop(context);

        }).catc(hError((error)=>print(error));
        }, child: Text("Save")),
      ],
    ));
  }
}
