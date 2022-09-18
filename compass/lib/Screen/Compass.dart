import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double? heading = 0;
  @override
  void initState() {
    FlutterCompass.events!.listen((event) {
      if(this.mounted){
        setState(() {
          heading = event.heading!;
        });
      }

    });
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  // done
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Compass',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${heading!.ceil()}°",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/cadrant.png'),
                Transform.rotate(
                  angle: ((heading ?? 0) * (pi / 180) * -1),
                  child: Image.asset(
                    'assets/compass.png',
                    scale: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}