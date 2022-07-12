import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  TextEditingController Sname=new TextEditingController();
  bool isLoading=false;
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Subjects"),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading?saveloading:Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: Sname,
                validator: (value){
                  if(value!.isEmpty){
                    return "Empty field not allowed";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter Class name",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.class__outlined,
                    color: Colors.deepPurple,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 3, color: Colors.deepPurple),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 35, vertical: 15),
                        primary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      if(!_formkey.currentState!.validate()){
                        return;
                      }
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          isLoading=true;
                        });
                        final uid=await getUserId();
                        await FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('subjects').add({
                          'sname':Sname.text
                        }).then((value){
                          setState(() {
                            isLoading=false;
                          });
                          Sname.clear();
                          const snackBar = SnackBar(
                            content: Text('Data Save Successfully'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }).catchError((onError){
                          print(onError);
                        });


                      }
                    },
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 35, vertical: 15),
                        primary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
