import 'package:flutter/material.dart';

void main() {
  runApp(PasswordApp());
}
class PasswordApp extends StatelessWidget {
  const PasswordApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pocket Password App",
      home: DashBoard(),
    );
  }
}
class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pocket Password App"),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              OptionButton(
                text: "Create Simple Password",
                onpressed: (){},
              ),
              SizedBox(
                height: 10.0,
              ),
              OptionButton(
                text: "Create Tough Password",
                onpressed: (){},
              ),
              SizedBox(
                height: 10.0,
              ),
              OptionButton(
                text: "Show All Password",
                onpressed: (){},
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  OptionButton({required this.text,required this.onpressed});
  final String text;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pink,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),

    );
  }
}


