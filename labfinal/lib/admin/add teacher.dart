
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:uuid/uuid.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);
  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  TextEditingController tname =  TextEditingController();
  TextEditingController temail =  TextEditingController();
  TextEditingController tphone =  TextEditingController();
  TextEditingController tpassword =  TextEditingController();
  var tsubject;
  var tclasses;
  bool isLoading=false;


  final _formkey = GlobalKey<FormState>();

  bool emailValidation(String e) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(e);
    return emailValid;
  }

  final ImagePicker _picker = ImagePicker();
  File? pickimage;
  String? imageURL;
  String? acedemy;




  Future getCameraImage() async {
    var img = await _picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        pickimage = File(img.path);
      });
    }
  }
  Future getGalleryImage() async {
    var img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        pickimage = File(img.path);
      });
    }
  }
  Stream<QuerySnapshot> getClassData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('classes').snapshots();
}
  Stream<QuerySnapshot> getSubjectData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('subjects').snapshots();
  }
  @override
  void initState() {
    getDoc();

    super.initState();
  }
  getDoc() async{
    FirebaseFirestore.instance.collection('Acedemy').doc(FirebaseAuth.instance.currentUser!.uid).collection('user').get().then((document) {
    acedemy=document.docs[0]['acedemy'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Teacher"),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading?saveloading:SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.deepPurple,
                      child: CircleAvatar(
                        radius: 75,
                        child: pickimage == null
                            ? Icon(
                                Icons.camera_enhance_outlined,
                                color: Colors.grey,
                                size: 70,
                              )
                            : null,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            pickimage == null ? null : FileImage(pickimage!),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 105,
                    left: 105,
                    child: RawMaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    "Choose Option",
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            getCameraImage();
                                            Navigator.pop(context);
                                          },
                                          splashColor: Colors.purple,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.camera,
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                              Text("Camera"),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            getGalleryImage();
                                            Navigator.pop(context);
                                          },
                                          splashColor: Colors.purple,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.photo,
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                              Text("Gallery"),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          splashColor: Colors.purple,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                              Text("Remove"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      fillColor: Colors.deepPurple,
                      elevation: 10,
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.camera_enhance,
                        color: Colors.white,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: tname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty field not allowed";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter Teacher name",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: temail,
                  validator: (value) {
                    if (!emailValidation(value!) || value.isEmpty) {
                      return "Please enter valid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Teacher Email",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.deepPurple,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: tphone,
                  validator: (value) {
                    if (value!.isEmpty || value.length != 11) {
                      return "Please enter valid phone no";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Teacher Phone no",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.deepPurple,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: getSubjectData(),
                builder: (context,AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Data not available",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.class__rounded,
                            color: Colors.deepPurple,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(width: 3, color: Colors.deepPurple),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(width: 3, color: Colors.deepPurple),
                          ),
                        ),
                      ),
                      );
                    }
                    else{
                      List<DropdownMenuItem>subjectname=[];
                      for(int i=0;i<snapshot.data.docs.length;i++){
                        DocumentSnapshot snap=snapshot.data.docs[i];
                        subjectname.add(
                          DropdownMenuItem(
                            child: Text(snap['sname'],style: TextStyle(color: Colors.deepPurple,fontSize: 20),),
                          value: "${snap['sname']}",
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 3
                            ),
                            borderRadius: BorderRadius.circular(10),
                           
                          ),
                          child: Row(
                            children:[
                              Icon(Icons.class__rounded,color: Colors.deepPurple,),
                              SizedBox(width: 20,),
                              DropdownButton<dynamic>(
                                items: subjectname, onChanged: (subject){
                                setState(() {
                                  tsubject=subject;
                                });
                              },
                                value: tsubject,
                                hint: Text("Select Subject",style: TextStyle(color: Colors.deepPurple,fontSize: 18,),),



                              ),

                            ],
                          ),
                        ),
                      );

                    }
                },
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: getClassData(),
                builder: (context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Data not available",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.class__rounded,
                            color: Colors.deepPurple,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(width: 3, color: Colors.deepPurple),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(width: 3, color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    );
                  }
                  else{
                    List<DropdownMenuItem>classname=[];
                    for(int i=0;i<snapshot.data.docs.length;i++){
                      DocumentSnapshot snap=snapshot.data.docs[i];
                      classname.add(
                        DropdownMenuItem(
                          child: Text(snap['cname'],style: TextStyle(color: Colors.deepPurple,fontSize: 20),),
                          value: "${snap['cname']}",
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepPurple,
                              width: 3
                          ),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          children:[
                            Icon(Icons.class__rounded,color: Colors.deepPurple,),
                            SizedBox(width: 20,),
                            DropdownButton<dynamic>(
                              items: classname, onChanged: (classes){
                              setState(() {
                                tclasses=classes;
                              });
                            },
                              value: tclasses,
                              hint: Text("Select Classes",style: TextStyle(color: Colors.deepPurple,fontSize: 18,),),


                            ),

                          ],
                        ),
                      ),
                    );

                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: tpassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty field not allowed";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Genrate Teacher Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.deepPurple,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 3, color: Colors.deepPurple),
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
                        if (!_formkey.currentState!.validate()) {



                          return;
                        }
                        if(_formkey.currentState!.validate()){
                          if(tclasses!=null&&tsubject!=null&&pickimage!=null){
                                setState(() {
                                  isLoading=true;
                                });
                                  final uid=await getUserId();
                                  UploadTask uploadtask=FirebaseStorage.instance.ref().child('teacherimage').child(Uuid().v1()).putFile(pickimage!);
                                  TaskSnapshot tasksnaphot=await uploadtask;
                                  imageURL=await tasksnaphot.ref.getDownloadURL();



                                  FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('teacher').add({
                                    'tname':tname.text,
                                    'temail':temail.text,
                                    'tphone':tphone.text,
                                    'tsubject':tsubject,
                                    'tclass':tclasses,
                                    'img':imageURL,
                                    'pas':tpassword.text,
                                    'acedemy':acedemy
                                  });
                                    setState(() {
                                      isLoading=false;
                                      pickimage=null;
                                      tclasses=null;
                                      tsubject=null;
                                    });
                                    tname.clear();
                                    temail.clear();
                                    tphone.clear();
                                    tname.clear();
                                    tpassword.clear();
                                    const snackBar = SnackBar(
                                      content: Text('Data Save Successfully'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);








                          }
                          else{
                            const snackBar = SnackBar(
                              content: Text('Please fill all data'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          }

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
      ),
    );
  }
}
