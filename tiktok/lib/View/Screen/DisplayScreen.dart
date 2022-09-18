import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/Controller/PlayVideoController.dart';
import 'package:tiktok/View/Widgets/AlbumRotator.dart';

import '../Widgets/ProfileButton.dart';
import '../Widgets/TiktokvideoPlayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class DisplayVideoScreen extends StatelessWidget {
    DisplayVideoScreen({Key? key}) : super(key: key);

  final VideoPlayController videoPlayController=Get.put(VideoPlayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
            (){
            return PageView.builder(

              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: 0,viewportFraction: 1),
                itemCount: videoPlayController.videoList.length,
                itemBuilder: (context,index){
                final data=videoPlayController.videoList[index];
                return Stack(
                  children: [
                    TiktokVideoPlayer(videoUrl: data.videoUrl),

                    Container(
                      margin: EdgeInsets.only(left: 15,bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("@${data.username}",style: TextStyle(fontSize: 18),),
                          Text(data.caption,),
                          Text(data.songname,),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height-390,

                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3,right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProfileButton(profilePhotoUrl: data.ProfilePic),

                            InkWell(
                              onTap: (){
                                videoPlayController.likeVideo(data.id);
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.favorite,size: 40,color: Colors.red,),
                                  Text(data.likes.length.toString(),style: TextStyle(fontSize: 15,color: Colors.white),),
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                Icon(Icons.reply,size: 40,color: Colors.white,),
                                Text(data.sharecount.toString(),style: TextStyle(fontSize: 15,color: Colors.white),),
                              ],
                            ),

                            Column(
                              children: [
                                Icon(Icons.comment,size: 40,color: Colors.white,),
                                Text(data.commentscount.toString(),style: TextStyle(fontSize: 15,color: Colors.white),),

                              ],
                            ),
                            AlbumRotator(profilePicUrl: data.ProfilePic),


                          ],
                        ),
                      ),
                    ),
                  ],
                );
                });
          }
        ),
      ),
    );
  }
}


