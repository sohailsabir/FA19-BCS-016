import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/Component/Constants.dart';
import 'package:tiktok/Controller/Video_Contoller.dart';
import 'package:tiktok/View/Widgets/textinput.dart';
import 'package:video_player/video_player.dart';

class AddCaptionScreen extends StatefulWidget {
  AddCaptionScreen({required this.videoFile,required this.videoPath});
  File videoFile;
  String videoPath;


  @override
  _AddCaptionScreenState createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songname=TextEditingController();
  TextEditingController captionController=TextEditingController();
  UploadVideoController uploadVideoController=Get.put(UploadVideoController());
  bool play=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController=VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.10);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }
  void check(){
    if(play==true){
      setState(() {
        videoPlayerController.play();
      });
    }
    else{
      videoPlayerController.pause();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.5,
                child: Stack(
                  children: [
                    VideoPlayer(videoPlayerController),
                    Center(child: FloatingActionButton(
                      child: Icon(!play?Icons.play_arrow:Icons.pause,color: Colors.white,),
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      onPressed: (){
                      setState(() {
                        play=!play;
                        check();
                      });
                    },)),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5,
                margin:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,

                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                     TextInput(controller: songname, myicon: Icons.music_note, mylabeltext: "Song name"),
                      SizedBox(
                        height: 20,
                      ),
                      TextInput(controller: captionController, myicon: Icons.closed_caption, mylabeltext: "Caption"),
                    ],
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                uploadVideoController.uploadVideo(songname.text, captionController.text, widget.videoPath);
              }, child: Text("Upload"),style: ElevatedButton.styleFrom(
                primary: buttonColor,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
