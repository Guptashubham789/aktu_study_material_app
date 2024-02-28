import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:studymaterialapp/views/user/UserDashScreen.dart';
import '../model/user-model.dart';
import 'get-device-token-controller.dart';

class GoogleSignInController extends GetxController{
  final GoogleSignIn googleSignIn=GoogleSignIn();
  final FirebaseAuth auth=FirebaseAuth.instance;

  Future<void> signInWithGoogle() async{
    final GetDeviceTokenController getDeviceTokenController=Get.put(GetDeviceTokenController());
    try{

      final GoogleSignInAccount? googleSignInAccount=await googleSignIn.signIn();

      if(googleSignInAccount!=null){
        EasyLoading.show(status: "please wait...");
        final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

        final AuthCredential credential=GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential=
        await auth.signInWithCredential(credential);

        final User? user=userCredential.user;

        if(user!=null){
          UserModel userModel=UserModel(
            uId: user.uid,
            username: user.displayName.toString(),
            useremail: user.email.toString(),
            userImg: user.photoURL.toString(),
            userDeviceToken: getDeviceTokenController.deviceToken.toString(),
            isActive: true, //user ko enable aur disable kar sakte haiadmin
            isAdmin: false,
            createdOn: DateTime.now(),
          );
          FirebaseFirestore.instance.collection('users')
              .doc(user.uid).set(userModel.toMap());
          EasyLoading.dismiss();
          Get.offAll(()=> const UserDashScreen());
        }

      }
    }catch(e){
      EasyLoading.dismiss();
      print("Eroor $e");
    }
  }
}