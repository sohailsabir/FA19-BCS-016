import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TiktokVideoPlayer extends StatefulWidget {
 TiktokVideoPlayer({required this.videoUrl});
 String videoUrl;

  @override
  _TiktokVideoPlayerState createState() => _TiktokVideoPlayerState();
}

class _TiktokVideoPlayerState extends State<TiktokVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool play=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController=VideoPlayerController.network(widget.videoUrl)..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  void check(){
    if(play==true){
      videoPlayerController.play();
    }
    else{
      videoPlayerController.pause();
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          play=!play;
        });
        check();
        print(play);
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black,

            ),
            child: VideoPlayer(videoPlayerController),
          ),
          Center(
            child:!play?Icon(Icons.play_arrow,color: Colors.grey,size: 50,):null,
          ),
        ],
      ),
    );
  }
}
