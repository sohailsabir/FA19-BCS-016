import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Component/Loading.dart';

class AddClass extends StatefulWidget {
  const AddClass({Key? key}) : super(key: key);

  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  TextEditingController Cname=new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Classes"),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading?saveloading:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.webp"),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: Cname,
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
                          await FirebaseFirestore.instance.collection('classes').add({
                            'cname':Cname.text
                          }).then((value){
                            setState(() {
                              isLoading=false;
                            });
                            Cname.clear();
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
      ),

    );
  }
}
