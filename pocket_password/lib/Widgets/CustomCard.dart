import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/Method.dart';
import 'package:pocket_password/Encrypt%20and%20Decrypt/Encryptdata.dart';
import 'package:share_plus/share_plus.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {required this.snapshot,
        required this.index,
        required this.passvisibiliy});

  final QuerySnapshot snapshot;
  final int index;
  final bool passvisibiliy;


  @override
  Widget build(BuildContext context) {
    var docId = snapshot.docs[index].id;
    TextEditingController pass =
    new TextEditingController(text: snapshot.docs[index]['password']);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade400,
                radius: 25.0,
                child: Text(
                  "${snapshot.docs[index]['name'][0]}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.docs[index]['name']}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Text(
                        passvisibiliy
                            ? "**********"
                            : "${snapshot.docs[index]['password']}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
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
                  onPressed: () {
                    FlutterClipboard.copy(snapshot.docs[index]["password"])
                        .then((value) {
                      const snackBar = SnackBar(
                        content: Text('Password Copied'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Colors.lightBlue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String name = snapshot.docs[index]['name'];
                    String password = snapshot.docs[index]['password'];

                    Share.share("$name" ": $password",
                        subject: snapshot.docs[index]['name']);
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.lightBlue,
                  ),
                ),
                IconButton(
                  onPressed: () async {
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
                                )),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                if (pass.text.isNotEmpty) {
                                  final uid = await getUserId();
                                  FirebaseFirestore.instance
                                      .collection('PasswordBD')
                                      .doc(uid)
                                      .collection("password")
                                      .doc(docId)
                                      .update({
                                    "password": pass.text,
                                  }).then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    // final uid=await getUserId();
                    //
                    //  var FirebaseReference=FirebaseFirestore.instance.collection('PasswordBD').doc(uid).collection("password");
                    //  await FirebaseReference.doc(docId).delete();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final uid=await getUserId();

                                  var FirebaseReference=FirebaseFirestore.instance.collection('PasswordBD').doc(uid).collection("password");
                                  await FirebaseReference.doc(docId).delete();


                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}