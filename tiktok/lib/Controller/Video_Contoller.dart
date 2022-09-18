import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/Model/Video.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{
  static UploadVideoController instance=Get.find();
  var uuid=Uuid();

  Future<File>_getThumb(String videoPath)async{
    final thumbnail=await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }


  Future<String>_UploadVideoThumbToStorage(String id,String videoPath)async{
    Reference reference=FirebaseStorage.instance.ref().child('thumbnail').child(id);
    UploadTask uploadTask=reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl=await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  uploadVideo(String songname,String caption,String videopath)async{
    try{
      String uid=FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('users').doc(uid).get();
      //video id
      String id=uuid.v1();
      String videoUrl=await uploadVideoToStorage(id,videopath);
      String thumbnail=await _UploadVideoThumbToStorage(id,videopath);
      Video video=Video(username: (userDoc.data()!as Map<String,dynamic>)['name'], thumbnail: thumbnail, uid: uid, songname: songname, caption: caption, commentscount: 0, id: id, likes: [], ProfilePic: (userDoc.data()!as Map<String,dynamic>)['profilePic'], sharecount: 0, videoUrl: videoUrl);
      await FirebaseFirestore.instance.collection("Videos").doc(id).set(video.toJson());
      Get.snackbar("Video Uploaded", "Thank You! Sharing your content  ");
      Get.back();
    }catch(e){
      Get.snackbar("Error while Uploaded", e.toString());
    }


  }


  Future<String>uploadVideoToStorage(String videoID,String videoPath)async{
    Reference reference=FirebaseStorage.instance.ref().child('Videos').child(videoID);
    UploadTask uploadTask=reference.putFile(await _compressedVideo(videoPath));
    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl=await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


 _compressedVideo(String VideoPath)async{
    final compressVideo=await VideoCompress.compressVideo(VideoPath,quality: VideoQuality.MediumQuality);
    return compressVideo!.file;
  }


}