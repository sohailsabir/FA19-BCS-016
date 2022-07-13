import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/firebaseAuthentication.dart';

class AddFees extends StatefulWidget {
  const AddFees({Key? key}) : super(key: key);

  @override
  _AddFeesState createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {
  Stream<QuerySnapshot> getClassData()async*{
    final uid=await getUserId();
    yield* FirebaseFirestore.instance.collection('Acedemy').doc(uid).collection('classes').snapshots();
  }
  Stream<QuerySnapshot> getUserData() async* {
    final uid = await getUserId();
    yield* FirebaseFirestore.instance
        .collection('Acedemy')
        .doc(uid)
        .collection('fees')
        .snapshots();
  }
  var feeclass;
  bool isLoading=false;
  TextEditingController fees=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Fees"),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: fees,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Empty field not allowed";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter class Fees",
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
                    if(feeclass!=null&&fees.text.isNotEmpty){
                      setState(() {
                        isLoading=true;
                      });
                      final uid=await getUserId();
                      FirebaseFirestore.instance.collection("Acedemy").doc(uid).collection('fees').add({
                        'name':feeclass,
                        'fees':fees.text

                      });

                      setState(() {
                        isLoading=false;
                        feeclass=null;
                        fees.clear();

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
          SizedBox(height: 60),
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
                        return FeesCustomeCard(snapshot: snapshot.data, index: index);
                      }),
                );

              }),
        ],
      ),

    );
  }
}
class FeesCustomeCard extends StatelessWidget {
  FeesCustomeCard({required this.snapshot,required this.index});
  final int index;
  final QuerySnapshot snapshot;


  @override
  Widget build(BuildContext context) {
    final _docid = snapshot.docs[index].id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        child: ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      Text("Class name:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(snapshot.docs[index]['name']),
                    ],
                  ),
                  IconButton(onPressed: ()async{
                    final uid = await getUserId();
                    var FirebaseReference = FirebaseFirestore.instance
                        .collection('Acedemy').doc(uid).collection(
                        "fees");
                    await FirebaseReference.doc(_docid).delete();
                  }, icon: Icon(Icons.delete_forever_sharp,color: Colors.red,),),

                ],
              ),
              Text("Fees:  ${snapshot.docs[index]['fees']}")
            ],
          ),
        ),
      ),
    );
  }
}
