import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/Component/Constants.dart';
import 'package:tiktok/View/Screen/AddCaptionScreen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);
  videoPick(ImageSource src,BuildContext context)async{
    final video=await ImagePicker().pickVideo(source: src);
    if(video!=null)
      {
        Get.snackbar("Video Select", video.path);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCaptionScreen(videoFile: File(video.path), videoPath: video.path)));
      }
    else{
      Get.snackbar("Error", "Please Select Different Video");
    }
  }
  showDialogOpt(BuildContext context){
    return showDialog(context: context, builder: (context)=>SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: ()=>videoPick(ImageSource.gallery,context),
          child: Row(
            children: [
              Icon(Icons.gamepad),
              SizedBox(width: 20,),
              Text("Gallery"),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: ()=>videoPick(ImageSource.camera,context),
          child: Row(
            children: [
              Icon(Icons.camera),
              SizedBox(width: 20,),
              Text("Camera"),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.cancel_outlined),
              SizedBox(width: 20,),
              Text("Cancel"),
            ],
          ),
        ),
      ],
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: ()=>showDialogOpt(context),
            child: Container(
              width: 190,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(child: Text("Upload Video",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
            ),
          ),
        ),
      ),
    );
  }
}
