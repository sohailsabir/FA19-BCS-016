import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';
import 'package:labfinal/PDFFuction/pdfStudentContact.dart';


class StudentContact extends StatefulWidget {
  const StudentContact({Key? key}) : super(key: key);

  @override
  _StudentContactState createState() => _StudentContactState();
}

class _StudentContactState extends State<StudentContact> {
  List Pdfdata = [];
  bool loading=false;
  final PdfStudentservices _pdfStudentservices=PdfStudentservices();
  getData() async {
    final uid = await getUserId();
    await FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection("student").where("class",isEqualTo: feeclass).get().then((value) {
      for(var i in value.docs) {
        Pdfdata.add(i.data());


      }
    });
  }
  
  
  
  
  Stream<QuerySnapshot> getClassData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('classes').snapshots();
  }
  var feeclass;
  TextEditingController fees=TextEditingController();
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Print Students Contact"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
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
                            feeclass=classes;
                          });
                        },
                          value: feeclass,
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
            height: 40,
          ),

          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    if(feeclass!=null){
                      print(feeclass);
                      await getData();
                      if(Pdfdata.isNotEmpty)
                      {

                        final data=await _pdfStudentservices.createPdf(Pdfdata);
                        _pdfStudentservices.saveAndLanchFile(data, "Studentcontact.pdf");
                        Pdfdata.clear();

                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text('Data not available'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Please Select any class'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                    
                  },
                  child: Text("Print"),
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

    );
  }
}

