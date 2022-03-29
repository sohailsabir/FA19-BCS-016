import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:xylophone/About.dart';
import 'inputpage.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: XyloPhone(
            colorn1: Colors.red,
            colorn2: Colors.yellow,
            colorn3: Colors.green,
            colorn4: Colors.teal,
            colorn5: Colors.deepPurple,
            colorn6: Colors.cyan,
            colorn7: Colors.purple,
            n1: 1,
            n2: 2,
            n3: 3,
            n4: 4,
            n5: 5,
            n6: 6,
            n7: 7),
        duration: 5000,
        imageSize: 130,
        imageSrc: "assets/logo.png",
        text: "Xylophone",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 40.0,
        ),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        backgroundColor: Colors.pink.shade300,
      ),
    );
  }
}
class XyloPhone extends StatelessWidget {
  XyloPhone(
      {required this.colorn1,
      required this.colorn2,
      required this.colorn3,
      required this.colorn4,
      required this.colorn5,
      required this.colorn6,
      required this.colorn7,
      required this.n1,
      required this.n2,
      required this.n3,
      required this.n4,
      required this.n5,
      required this.n6,
      required this.n7});

  final Color colorn1;
  final Color colorn2;
  final Color colorn3;
  final Color colorn4;
  final Color colorn5;
  final Color colorn6;
  final Color colorn7;
  final int n1;
  final int n2;
  final int n3;
  final int n4;
  final int n5;
  final int n6;
  final int n7;
  final playerSound = AudioCache();

  void playSound(int num) {
    playerSound.play("note$num.wav");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade500,
        title: Text("XyloPhone"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Xylophone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink.shade300,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Change Theme"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ColorPickerScreen(),),);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Aboutpage(),),);
              },
            ),

          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              xylobutton(
                  colorn1: colorn1,
                  play: () {
                    playSound(n1);
                  }),
              xylobutton(
                colorn1: colorn2,
                play: () {
                  playSound(n2);
                },
              ),
              xylobutton(
                colorn1: colorn3,
                play: () {
                  playSound(n3);
                },
              ),
              xylobutton(
                colorn1: colorn4,
                play: () {
                  playSound(n4);
                },
              ),
              xylobutton(
                  colorn1: colorn5,
                  play: () {
                    playSound(n5);
                  }),
              xylobutton(
                colorn1: colorn6,
                play: () {
                  playSound(n6);
                },
              ),
              xylobutton(
                colorn1: colorn7,
                play: () {
                  playSound(n7);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class xylobutton extends StatelessWidget {
  const xylobutton({required this.colorn1, required this.play});

  final Color colorn1;
  final VoidCallback play;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: play,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.adjust),
            Icon(Icons.adjust),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: colorn1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
