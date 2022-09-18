import 'package:flutter/material.dart';
class AlbumRotator extends StatefulWidget {
  String profilePicUrl;
  AlbumRotator({required this.profilePicUrl});

  @override
  State<AlbumRotator> createState() => _AlbumRotatorState();
}

class _AlbumRotatorState extends State<AlbumRotator> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(vsync: this,duration: Duration(seconds: 5));
    controller.forward();
    controller.repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
     return RotationTransition(
       turns: Tween(begin: 0.0,end: 1.0).animate(controller),
       child: SizedBox(
        width: 55,
        height: 55,
        child: Column(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey,
                    Colors.white,
                  ],

                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(image: NetworkImage(widget.profilePicUrl),
                fit: BoxFit.cover,
                ),

              ),
            )
          ],
        ),
    ),
     );
  }
}
