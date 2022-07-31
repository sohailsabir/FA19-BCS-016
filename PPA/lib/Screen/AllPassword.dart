

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppa/Services/UserServices.dart';
import 'package:ppa/db/Database.dart';
import 'package:ppa/db/passwordmodel.dart';
import 'package:share_plus/share_plus.dart';

import '../PDF service/mobile.dart';


class AllPassword extends StatefulWidget {
  const AllPassword({Key? key}) : super(key: key);

  @override
  _AllPasswordState createState() => _AllPasswordState();
}

class _AllPasswordState extends State<AllPassword> {
  final Pdfservices _pdfservices=Pdfservices();
  List Pdfdata = [];
  int _selectedIndex = -1;
  bool passvisibility=false;
  String name="";
  bool searchState = false;
  TextEditingController searchcontroller = TextEditingController();

  void _onItemTapped(int index) async{
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
    if(_selectedIndex==0)
      {
        setState(() {
          passvisibility=!passvisibility;
        });
      }
    if(_selectedIndex==1){
      await getData();
      if(Pdfdata.isNotEmpty)
      {
        final data= await _pdfservices.createPdf(Pdfdata);
        _pdfservices.saveAndLanchFile(data, "Pocket Password.pdf");
        Pdfdata.clear();
      }
      else{
        const snackBar = SnackBar(
          content: Text('Something went wronge'),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    }
  }
  
  
  //
  // getPassword()async{
  //   var password;
  //   // password=await Databaseprovider.db.getPassword();
  //   return password;
  //
  // }
   List<ModelPass>_userList=[];
  final _userService=UserServices();
  getAllUserPassword()async{
    var users=await _userService.ReadAllPassword();
    setState(() {
      _userList=<ModelPass>[];
    });

    users.forEach((user){
      setState(() {
        var modelPass=ModelPass();
        modelPass.id=user['id'];
        modelPass.title=user['title'];
        modelPass.pass=user['pass'];
        _userList.add(modelPass);
      });
    });
  }
  @override
  void initState() {
    getAllUserPassword();
    super.initState();
  }


  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: !searchState
            ? Text("All Passwords")
            : TextField(
          controller: searchcontroller,
          cursorColor: Colors.white,

          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search here...",
            hintStyle: TextStyle(color: Colors.white),
            focusColor: Colors.teal,

          ),
          onChanged: (value){
            setState(() {
              name=value;
            });
          },

        ),
        backgroundColor: Colors.teal,
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

        ],
      ),
      // body:FutureBuilder(
      //   future: password,
      //   builder: (context,AsyncSnapshot passData){
      //     switch(passData.connectionState){
      //       case ConnectionState.waiting:{
      //         return Center(child: CircularProgressIndicator(),);
      //       }
      //       case ConnectionState.done:{
      //         if(passData.data==null){
      //           return Center(child: Text("Nothing to show"),);
      //         }
      //         else{
      //           return Padding(
      //             padding: EdgeInsets.all(8.0),
      //             child: ListView.builder(
      //               itemCount: passData.data.length,
      //               itemBuilder: (context,index){
      //                 String title=passData.data[index]['title'];
      //                 String pass=passData.data[index]['pass'];
      //                 int id=passData.data[index]['id'];
      //                 return Card(
      //                   elevation: 7.0,
      //
      //                   child: Column(
      //                     children: [
      //                       ListTile(
      //                         title: Text(title),
      //                         subtitle: Text(pass),
      //                         leading: CircleAvatar(
      //                             backgroundColor: Colors.blue.shade400,
      //                           child: Text(title[0].toUpperCase(),style: TextStyle(
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.bold,
      //                           ),),
      //                         ),
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //                           IconButton(onPressed: (){}, icon: Icon(Icons.copy,color: Colors.blue,),),
      //                           IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.blue,),),
      //                           IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.blue,),),
      //                           IconButton(
      //                             onPressed: ()async{
      //                               await showDialog(
      //                                   context: context,
      //                                   builder: (BuildContext context) {
      //                                 return AlertDialog(
      //                                   title: Text('Are you sure?'),
      //                                   actions: [
      //                                     TextButton(
      //                                       onPressed: (){
      //                                         Navigator.pop(context);
      //                                         },
      //                                       child: Text(
      //                                         'NO',
      //                                         style: TextStyle(color: Colors.pink),
      //                                       ),
      //                                     ),
      //                                     TextButton(
      //                                       onPressed: () {
      //
      //                                         // Databaseprovider.db.detelePassword(id);
      //                                         Navigator.pop(context);
      //                                       },
      //                                       child: Text(
      //                                         'Yes',
      //                                         style: TextStyle(color: Colors.blue),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 );
      //                               });
      //                             },
      //                             icon: Icon(Icons.delete_forever_sharp,color: Colors.red,),),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         }
      //       }
      //       default:{
      //         return Container();
      //       }
      //     }
      //   },
      // ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _userList.length,
            itemBuilder: (context,index){
              if(_userList.isEmpty){
                return Center(child: CircularProgressIndicator());
              }
              if(_userList[index].title.toString().toLowerCase().startsWith(name.toLowerCase())){
                return Card(
                  elevation: 6.0,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.password,color: Colors.white,),
                          backgroundColor: Colors.teal,
                        ),
                        title: Text(_userList[index].title??'',style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(passvisibility?_userList[index].pass??'':"*********"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            FlutterClipboard.copy(_userList[index].pass??'')
                                .then((value) {
                              const snackBar = SnackBar(
                                content: Text('Password Copied'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            });
                          }, icon: Icon(Icons.copy,color: Colors.teal,),),
                          IconButton(onPressed: (){
                            String? name = _userList[index].title;
                            String? password = _userList[index].pass;

                            Share.share("$name" ": $password",
                                subject: name);
                          }, icon: Icon(Icons.share,color: Colors.teal,),),
                          IconButton(onPressed: ()async{
                            TextEditingController title=TextEditingController(text: _userList[index].title);
                            TextEditingController pass=TextEditingController(text: _userList[index].pass);
                            var modalpass=ModelPass();
                            int? passid=_userList[index].id;
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(child: Text('Update Password')),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: title,
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.title,
                                              color: Colors.teal,
                                            )),
                                      ),
                                      TextField(
                                        controller: pass,
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.password,
                                              color: Colors.teal,
                                            )),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        if (title.text.isNotEmpty&&pass.text.isNotEmpty) {
                                          modalpass.id=passid;
                                          modalpass.title=title.text;
                                          modalpass.pass=pass.text;
                                          var result=await _userService.UpdateUser(modalpass);
                                          getAllUserPassword();
                                          Navigator.pop(context);

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
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }, icon: Icon(Icons.edit,color: Colors.teal,),),
                          IconButton(onPressed: ()async{
                            int? passid=_userList[index].id;
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Are you sure?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          var result=await _userService.DeleteUserPass(passid);
                                          getAllUserPassword();
                                          Navigator.pop(context);



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
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                      ),
                                    ],
                                  );
                                });

                          }, icon: Icon(Icons.delete,color: Colors.red,),),
                        ],
                      ),

                    ],
                  ),

                );
              }
              return Container();


            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
       unselectedItemColor: Colors.white,
        iconSize: 30,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.teal.shade400,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(passvisibility?Icons.visibility:Icons.visibility_off,color: Colors.white,),label: 'Visibility'),
          BottomNavigationBarItem(icon: Icon(Icons.download_rounded),label: 'PDF'),


        ],

      ),

    );
  }
  getData() async {
    var users=await _userService.ReadAllPassword();
    users.forEach((user){
      setState(() {
        Pdfdata.add(user);
      });
    });
  }

}
