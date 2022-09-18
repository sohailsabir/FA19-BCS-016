import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String username;
  String uid;
  String id;
  List likes;
  int commentscount;
  int sharecount;
  String songname;
  String caption;
  String videoUrl;
  String thumbnail;
  String ProfilePic;

  Video({required this.username,required this.thumbnail,required this.uid,required this.songname,required this.caption,required this.commentscount,required this.id,required this.likes,required this.ProfilePic,required this.sharecount,required this.videoUrl});
  Map<String,dynamic> toJson()=>{
    "username":username,
    "uid":uid,
    "profilePic":ProfilePic,
    "id":id,
    "likes":likes,
    "commentscount":commentscount,
    "sharecount":sharecount,
    "songname":songname,
    "caption":caption,
    "videoUrl":videoUrl,
    "thumbnail":thumbnail

  };
  static Video fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data()as Map<String,dynamic>;
    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      ProfilePic: snapshot['profilePic'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentscount: snapshot['commentscount'],
      sharecount: snapshot['sharecount'],
      songname: snapshot['songname'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],

    );
  }
}