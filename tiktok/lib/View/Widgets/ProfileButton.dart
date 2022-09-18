import 'package:flutter/material.dart';
class ProfileButton extends StatelessWidget {
  ProfileButton({required this.profilePhotoUrl});
  String profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              padding: EdgeInsets.all(1),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image(
                image: NetworkImage(profilePhotoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
