import 'package:flutter/material.dart';

class ToughPasswordScreen extends StatefulWidget {
  const ToughPasswordScreen({Key? key}) : super(key: key);

  @override
  _ToughPasswordScreenState createState() => _ToughPasswordScreenState();
}

class _ToughPasswordScreenState extends State<ToughPasswordScreen> {
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create Tough Password"),
        backgroundColor: Colors.pink,
      ),
      body:  Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Length of Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Characters in the Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Symbol in the Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digit in the Password",
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  icon: Icon(
                    Icons.edit_location_sharp,
                    color: Colors.pink,
                  )

              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Password Like: ab@1A",
                  icon: Icon(
                    Icons.password,
                    color: Colors.pink,
                  )
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      check=true;
                    });


                  },
                  child: Text("Create Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: check==false?null:(){},
                  child: Text("Save Password"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
