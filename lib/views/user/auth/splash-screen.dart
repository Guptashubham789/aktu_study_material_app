import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:studymaterialapp/views/admin/admin-dash-screen.dart';
import 'package:studymaterialapp/views/user/UserDashScreen.dart';
import 'package:studymaterialapp/views/user/auth/user-main-screen.dart';

import '../../../constant/app-constant.dart';
import '../../../controller/get-user-data-controller.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
     // Get.to(()=>WelcomeScreen());
      loggdin(context);
    });
  }
  //it means cagr user login hai to hmesha login hi rhega jab tak logout nhi karta hai
  Future<void> loggdin(BuildContext context)async{
    //agr user nhi equal hai null ke to es condintion pr aaye
    if(user!=null){
      final GetUserDataController getUserDataController=Get.put(GetUserDataController());
      var userData=await getUserDataController.getUserData(user!.uid);
      if(userData[0]['isAdmin']==true){
        Get.offAll(()=>AdminDashScreen());
      }else{
        Get.offAll(()=>UserDashScreen());
      }
    }else{
     Get.to(()=>WelcomeScreen());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Image.asset("assets/img/splash.png"),
                ),
              ),
            ),Container(
              width: Get.width,
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Text(AppConstant.appPowerBy,style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'serif'),),
            )
          ],
        ),
      ),
    );
  }
}