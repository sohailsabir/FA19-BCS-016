import 'package:borad_app/Model.dart';
import 'package:borad_app/home.dart';
import 'package:borad_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);
}
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   var fireStoreDB=FirebaseFirestore.instance.collection("board").snapshots();
//   TextEditingController title=new TextEditingController();
//   TextEditingController des=new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chl Ja"),
//       ),
// body: StreamBuilder(
//   stream: fireStoreDB,
//   builder: (context,AsyncSnapshot snapshot){
//     if(!snapshot.hasData) return CircularProgressIndicator();
//     return ListView.builder(
//       itemCount: snapshot.data.docs.length,
//         itemBuilder: (context,int index)
//     {
//       return Text(snapshot.data.docs[index]["title"]);
//     });
//   },
// ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           _showDialog();
//         },
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   }
//
//   void _showDialog() async{
//     await showDialog(context: context, builder: (context)=>AlertDialog(
//       contentPadding: EdgeInsets.all(10),
//       title: Text("Enter Message Here"),
//       content: Column(
//         children: [
//           Expanded(child: TextField(
//             autofocus: true,
//             autocorrect: true,
//             decoration: InputDecoration(
//               hintText: 'Title',
//               labelText: "Title",
//
//             ),
//             controller: title,
//
//           ),),
//           Expanded(child: TextField(
//             autofocus: true,
//             autocorrect: true,
//             decoration: InputDecoration(
//               hintText: 'description',
//               labelText: "description",
//
//             ),
//             controller: des,
//
//           ),),
//         ],
//       ),
//       actions: [
//         ElevatedButton(onPressed: (){
//           title.clear();
//           des.clear();
//           Navigator.pop(context);
//         }, child: Text("Cancel")),
//         ElevatedButton(onPressed: (){
//         FirebaseFirestore.instance.collection('board').add({
//           "title":title.text,
//           "description":des.text,
//           "timeStamp":DateTime.now(),
//         }).then((value) {
//           print(value.id);
//           title.clear();
//           des.clear();
//           Navigator.pop(context);
//
//         }).catc(hError((error)=>print(error));
//         }, child: Text("Save")),
//       ],
//     ));
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AuthServices>(create: (_)=>AuthServices(FirebaseAuth.instance),),
      StreamProvider(create: (context)=>context.read<AuthServices>().authSatateChanges, initialData: null,),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}
class AuthWrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final user=context.watch<User?>();
    if(user==null)
      {
        return home();
      }
    return login();
  }
}

// class Create extends StatefulWidget {
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//
//
//   @override
//   State<Create> createState() => _CreateState();
// }
//
// class _CreateState extends State<Create> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     DatabaseReference test=FirebaseDatabase.instance.ref().child('Testing');
//     test.set("Wellcome Counter:$_counter");
//
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
