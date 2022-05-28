
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/Method.dart';
import 'package:pocket_password/Widgets/CustomCard.dart';
import 'package:pocket_password/Widgets/Loading.dart';


class ViewPasswordScreen extends StatefulWidget {
  const ViewPasswordScreen({Key? key}) : super(key: key);

  @override
  _ViewPasswordScreenState createState() => _ViewPasswordScreenState();
}

class _ViewPasswordScreenState extends State<ViewPasswordScreen> {
  // var firebaseDB = FirebaseFirestore.instance.collection("PasswordBD").snapshots();
  String name="";
  bool eyeVisibily = true;
  bool searchState = false;
  TextEditingController searchcontroller = TextEditingController();

  Stream<QuerySnapshot> getUserdata() async* {
    final uid = await getUserId();
    yield* FirebaseFirestore.instance
        .collection("PasswordBD")
        .doc(uid)
        .collection("password")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !searchState
            ? Text("View All Password")
            : TextField(
                controller: searchcontroller,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search here...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value){
                  setState(() {
                    name=value;
                  });
                },

              ),
        backgroundColor: Colors.blue,
        actions: [
          !searchState
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  icon: Icon(Icons.search))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                      searchcontroller.clear();
                      name="";
                    });
                  },
                  icon: Icon(Icons.cancel)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getUserdata(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Center(child: spinkit);
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index) {
                if(name.isEmpty){
                  return CustomCard(
                  snapshot: snapshot.data,
                  index: index,
                  icon: eyeVisibily ? Icons.visibility_off : Icons.visibility,
                  onpressed: () {
                    setState(() {
                      eyeVisibily = !eyeVisibily;
                    });
                  },
                  passvisibiliy: eyeVisibily,
                );
                }
                if(snapshot.data.docs[index]['name'].toString().toLowerCase().startsWith(name.toLowerCase())){
                  return CustomCard(
                    snapshot: snapshot.data,
                    index: index,
                    icon: eyeVisibily ? Icons.visibility_off : Icons.visibility,
                    onpressed: () {
                      setState(() {
                        eyeVisibily = !eyeVisibily;
                      });
                    },
                    passvisibiliy: eyeVisibily,
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


