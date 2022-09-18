import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/Model/User.dart';
import 'package:tiktok/View/Screen/Auth/Login_page.dart';

import '../View/Screen/HomeScreen.dart';

class AuthController extends GetxController{
  static AuthController instance=Get.find();
  File? proimg;
  picImage()async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null)return;
    final img=File(image.path);
    this.proimg=img;
  }

  //User Sate Persistence
   late Rx<User?> _user;
  User get user=>_user.value!;
  @override
  void onReady(){
    super.onReady();
    _user=Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user,_setInitialView);
    //Observable keyword check value
    print("ok");
  }
  _setInitialView(User? user){
    if(_user.isNull){

    }
    Get.offAll(()=>LoginScreen());
    // Get.offAll(()=>HomeScreen());
  }

  //user register

  void Signup(String username,String email,String password,File? image)async{
    try{
      if(username.isNotEmpty&&password.isNotEmpty&&email.isNotEmpty&&image!=null){
        UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl=await _uploadProPic(image);

        myUser user=myUser(uid: credential.user!.uid, email: email, name: username, profilePhoto: downloadUrl);
        await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.toJson());
      }
      else{
        Get.snackbar('Something went wronge ', 'Please enter all the required feilds');
      }

    }catch(e){
      print(e);
      Get.snackbar('Error Occurred', e.toString());
    }

  }
  Future<String>_uploadProPic(File image)async{
    Reference ref=FirebaseStorage.instance.ref().child('profilePics').child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask=ref.putFile(image);
    TaskSnapshot snapshot=await uploadTask;
    String imageDownUrl=await snapshot.ref.getDownloadURL();
    return imageDownUrl;
  }
  void login(String email,String password)async{
    try{
      if(email.isNotEmpty&& password.isNotEmpty){
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Get.offAll(HomeScreen());
        });
      }
      else{
        Get.snackbar("Error", "Please enter all the feilds");
      }
    }catch(e){
      Get.snackbar("Error", e.toString());
    }

  }

}