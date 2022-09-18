import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/Controller/auth_controller.dart';

import '../Model/Video.dart';

class VideoPlayController extends GetxController{
  final Rx<List<Video>> _videoList=Rx<List<Video>>([]);
  List<Video>get videoList=>_videoList.value;
  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance.collection("Videos").snapshots().map((QuerySnapshot query){
      List<Video>retValue=[];
      for(var element in query.docs){
        retValue.add(Video.fromSnap(element));
      }
      return retValue;
    }));
  }
  likeVideo(String id)async{
    DocumentSnapshot doc=await FirebaseFirestore.instance.collection('Videos').doc(id).get();
    var uid=AuthController.instance.user.uid;
    if((doc.data()as dynamic)['likes'].contains(uid)){
      await FirebaseFirestore.instance.collection('Videos').doc(id).update({
        'likes':FieldValue.arrayRemove([uid])
      });

    }else{
      await FirebaseFirestore.instance.collection('Videos').doc(id).update({
        "likes":FieldValue.arrayUnion([uid]),
      });
    }

  }
}