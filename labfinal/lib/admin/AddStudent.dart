import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labfinal/Component/Loading.dart';
import 'package:labfinal/admin/studentSubject.dart';
import 'package:uuid/uuid.dart';

import '../Authentication/firebaseAuthentication.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController sname =  TextEditingController();
  TextEditingController sphone =  TextEditingController();
  TextEditingController spassword =  TextEditingController();
  bool isLoading=false;
  var sclasses;
  String? acedemy;
  String? fees;


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
  @override
  void initState() {
    getDoc();

    super.initState();
  }



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

  getDoc() async{
    FirebaseFirestore.instance.collection('Acedemy').doc(FirebaseAuth.instance.currentUser!.uid).collection('user').get().then((document) {
      acedemy=document.docs[0]['acedemy'];
    });
  }
  loadFees() async{
    FirebaseFirestore.instance.collection('Acedemy').doc(FirebaseAuth.instance.currentUser!.uid).collection('fees').where("name",isEqualTo: sclasses).get().then((document) {
      fees=document.docs[0]['fees'];
    });
    print("***************${fees}*********");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        title: Text("Add Students"),
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
                  controller: sname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty field not allowed";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter Student name",
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
                                sclasses=classes;
                                loadFees();
                              });
                            },
                              value: sclasses,
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
                  controller: sphone,
                  validator: (value) {
                    if (value!.isEmpty || value.length != 11) {
                      return "Please enter valid phone no";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Student Phone no",
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: spassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Empty field not allowed";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Genrate Student Password",
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
                          if(sclasses!=null&&pickimage!=null){
                            await loadFees();
                            setState(() {
                              isLoading=true;

                            });
                            final uid=await getUserId();
                            UploadTask uploadtask=FirebaseStorage.instance.ref().child('studentimage').child(Uuid().v1()).putFile(pickimage!);
                            TaskSnapshot tasksnaphot=await uploadtask;
                            imageURL=await tasksnaphot.ref.getDownloadURL();
                            FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection('student').add({
                              'name':sname.text,
                              'class':sclasses,
                              'phone':sphone.text,
                              'password':spassword.text,
                              'img':imageURL,
                              'acedemy':acedemy,
                              'teacher':'',
                              'fees':fees,
                            });

                            setState(() {
                              isLoading=false;
                              pickimage=null;
                              sname.clear();
                              spassword.clear();
                              sphone.clear();

                            });

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
