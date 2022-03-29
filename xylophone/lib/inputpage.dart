import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'main.dart';

class ColorPickerScreen extends StatefulWidget {
  @override
  State<ColorPickerScreen> createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color n1 = Colors.cyan;
  Color n2 = Colors.pink;
  Color n3 = Colors.red;
  Color n4 = Colors.deepPurple;
  Color n5 = Colors.greenAccent;
  Color n6 = Colors.teal;
  Color n7 = Colors.grey;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  int sn1 = 1;
  int sn2 = 2;
  int sn3 = 3;
  int sn4 = 4;
  int sn5 = 5;
  int sn6 = 6;
  int sn7 = 7;

  void changeColor1(Color color) {
    setState(() {
      n1 = color;
    });
  }

  void changeColor2(Color color) {
    setState(() {
      n2 = color;
    });
  }

  void changeColor3(Color color) {
    setState(() {
      n3 = color;
    });
  }

  void changeColor4(Color color) {
    setState(() {
      n4 = color;
    });
  }

  void changeColor5(Color color) {
    setState(() {
      n5 = color;
    });
  }

  void changeColor6(Color color) {
    setState(() {
      n6 = color;
    });
  }

  void changeColor7(Color color) {
    setState(() {
      n7 = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pink.shade300,
      appBar: AppBar(
        title: Text("Change Theme"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(
                    right: 15.0, left: 15.0, top: 10.0, bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.pink.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller1,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note1 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller2,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note2 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller3,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note3 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller4,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note4 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller5,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note5 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller6,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note6 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller7,
                                decoration: InputDecoration(
                                    hintText: "Enter 1`to 7 number",
                                    labelText: "Note7 Sound",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    right: 15.0, left: 15.0, top: 10.0, bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.pink.shade100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n3,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor1,
                                        pickerColor: n1,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor2,
                                        pickerColor: n2,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor3,
                                        pickerColor: n3,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor4,
                                        pickerColor: n4,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n6,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: n7,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor5,
                                        pickerColor: n5,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor6,
                                        pickerColor: n6,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        onColorChanged: changeColor7,
                                        pickerColor: n7,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Apply Color"),
                                      )
                                    ],
                                  ));
                            },
                            child: Text("Change"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if(controller1.text.isEmpty||controller2.text.isEmpty||controller3.text.isEmpty||controller4.text.isEmpty||controller5.text.isEmpty||controller6.text.isEmpty||controller7.text.isEmpty)
                  {
                    sn1=1;
                    sn2=2;
                    sn3=3;
                    sn4=4;
                    sn5=5;
                    sn6=6;
                    sn7=7;
                  }

                  else{
                    sn1=int.parse(controller1.text);
                    sn2=int.parse(controller2.text);
                    sn3=int.parse(controller3.text);
                    sn4=int.parse(controller4.text);
                    sn5=int.parse(controller5.text);
                    sn6=int.parse(controller6.text);
                    sn7=int.parse(controller7.text);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => XyloPhone(
                        colorn1: n1,
                        colorn2: n2,
                        colorn3: n3,
                        colorn4: n4,
                        colorn5: n5,
                        colorn6: n6,
                        colorn7: n7,
                        n1: sn1,
                        n2: sn2,
                        n3: sn3,
                        n4: sn4,
                        n5: sn5,
                        n6: sn6,
                        n7: sn7,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.pink,
                  ),
                  margin: EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 10.0, bottom: 5.0),
                  width: double.infinity,
                  child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
