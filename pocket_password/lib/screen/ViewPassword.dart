
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_password/Authication/Method.dart';
import 'package:pocket_password/PdfFuction/mobile.dart';
import 'package:pocket_password/Widgets/CustomCard.dart';
import 'package:pocket_password/Widgets/Loading.dart';



class ViewPasswordScreen extends StatefulWidget {
  const ViewPasswordScreen({Key? key}) : super(key: key);

  @override
  _ViewPasswordScreenState createState() => _ViewPasswordScreenState();
}

class _ViewPasswordScreenState extends State<ViewPasswordScreen> {
  final Pdfservices _pdfservices=Pdfservices();
  List Pdfdata = [];
  bool loading=true;

  bool isFirstTime=false;
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
  // getDataForPdf() async {
  //   final uid = await getUserId();
  //   var data= FirebaseFirestore.instance
  //       .collection("PasswordBD")
  //       .doc(uid)
  //       .collection("password")
  //       .get();
  //   setState(() {
  //
  //   });
  //   return "Complete";
  // }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   dataloaded=getDataForPdf();
  //
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !searchState
            ? Text("All Passwords")
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
              onPressed: () {
                setState(() {
                  eyeVisibily=!eyeVisibily;
                });
              },
              icon: Icon(eyeVisibily?Icons.visibility_off:Icons.visibility)),
          IconButton(
            onPressed:()async{
                await getData();
                if(Pdfdata.isNotEmpty)
                  {
                    setState(() {
                      loading=true;
                    });
                    final data=await _pdfservices.createPdf(Pdfdata);
                    _pdfservices.saveAndLanchFile(data, "Pocket Password.pdf");
                    Pdfdata.clear();
                  }
                else{
                  setState(() {
                    loading=false;
                  });
                }

            },


            icon: Icon(loading?Icons.download_rounded:Icons.arrow_circle_down_sharp),
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
                  passvisibiliy: eyeVisibily,
                );
                }
                if(snapshot.data.docs[index]['name'].toString().toLowerCase().startsWith(name.toLowerCase())){
                  return CustomCard(
                    snapshot: snapshot.data,
                    index: index,
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
  // Future<void>_createPDF()async{
  //   final snapshot=getUserdata();
  //   PdfDocument document=PdfDocument();
  //   final page=document.pages.add();
  //   page.graphics.drawString("${snapshot}",PdfStandardFont(PdfFontFamily.helvetica, 30));
  //   List<int>bytes=document.save();
  //   document.dispose();
  //   saveAndLanchFile(bytes, "Output.pdf");
  // }
  // Future getDocs() async {
  //   final uid = await getUserId();
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("PasswordBD").doc(uid).collection("password").get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     return a;
  //   }
  // }
  getData() async {
    final uid = await getUserId();
    await FirebaseFirestore.instance.collection("PasswordBD").doc(uid).collection("password").get().then((value) {
      for(var i in value.docs) {
        Pdfdata.add(i.data());


      }
    });
  }
}


