import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/Component/Loading.dart';

class AddStudentSubject extends StatefulWidget {
   AddStudentSubject({required this.docid,required this.StudentClass});
   final String docid;
   final String StudentClass;

  @override
  _AddStudentSubjectState createState() => _AddStudentSubjectState();
}

class _AddStudentSubjectState extends State<AddStudentSubject> {
  Stream<QuerySnapshot> getSubjectData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('subjects').snapshots();
  }
  var ssubject;
  var teacher="Not available";
  bool isLoading=false;
  Stream<QuerySnapshot> getUserData() async* {
    final uid = await getUserId();
    yield* FirebaseFirestore.instance
        .collection('Acedemy')
        .doc(uid)
        .collection('student').doc(widget.docid).collection('studentsubject')
        .snapshots();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.StudentClass);
  }
  loadTeacher() async{
    FirebaseFirestore.instance.collection('Acedemy').doc(FirebaseAuth.instance.currentUser!.uid).collection('teacher').where("tsubject",isEqualTo: ssubject).where("tclass",isEqualTo: widget.StudentClass).get().then((document) {
      teacher=document.docs[0]['tname'];
    });
    print("***************${teacher}*********");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Student Subject"),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading?Center(child: saveloading,):Column(
        children: [
          SizedBox(height: 25),
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
                            ssubject=subject;
                            loadTeacher();
                          });
                        },
                          value: ssubject,
                          hint: Text("Select Subject",style: TextStyle(color: Colors.deepPurple,fontSize: 18,),),



                        ),

                      ],
                    ),
                  ),
                );

              }
            },
          ),
          SizedBox(height: 25),
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
                      if(ssubject!=null){
                        setState(() {
                          loadTeacher();
                          isLoading=true;
                        });
                          final uid=await getUserId();
                          FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection('student').doc(widget.docid).collection('studentsubject').add({
                            'name':ssubject,
                            'teacher':teacher,

                          });
                        FirebaseFirestore.instance.collection('student').doc(widget.docid).collection('studentsubject').add({
                          'name':ssubject,
                          'teacher':teacher,

                        });
                          setState(() {
                            isLoading=false;
                            ssubject=null;

                          });






                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text('Please fill all data'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
          SizedBox(height: 80),
          StreamBuilder(
            stream: getUserData(),
              builder: (context, AsyncSnapshot snapshot){
              if(!snapshot.hasData)
                {return Container(
                  child: Text("Nothing to show"),
                );


                }
             return Expanded(
               child: ListView.builder(
                 itemCount: snapshot.data.docs.length,
                   itemBuilder: (context,int index){
                 return StudentCustomeCard(snapshot: snapshot.data, index: index,document: widget.docid,);
               }),
             );

          }),

        ],
      ),
    );
  }
}

class StudentCustomeCard extends StatelessWidget {
   StudentCustomeCard({required this.snapshot,required this.index,required this.document});
   final int index;
   final QuerySnapshot snapshot;
   final String document;

  @override
  Widget build(BuildContext context) {
    final _docid = snapshot.docs[index].id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  children: [
                    Row(
                      children: [
                        Text("Subject name:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(snapshot.docs[index]['name']),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Teacher name:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(snapshot.docs[index]['teacher']),
                      ],
                    ),
                  ],
                ),
                IconButton(onPressed: ()async{
                  final uid = await getUserId();
                  var FirebaseReference = FirebaseFirestore.instance
                      .collection('Acedemy').doc(uid).collection(
                      "student").doc(document).collection('studentsubject');
                  await FirebaseReference.doc(_docid).delete();
                }, icon: Icon(Icons.delete_forever_sharp,color: Colors.red,),),

              ],
            ),
        ),
      ),
    );
  }
}

