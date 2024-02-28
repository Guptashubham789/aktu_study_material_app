import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../constant/app-constant.dart';
import '../../../controller/google-sign-in-controller.dart';
class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleSignInController _googleSignInController=Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text('Welcome To Study Material',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily,fontSize: 16),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  height: Get.height/2,
                  width: Get.width/1.0,
                  child: Image.asset('assets/img/splash.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text('Amazing Study App',
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w100,fontSize: 12),),
              ),
              SizedBox(
                height: Get.height/12,
              ),
              Material(
                child: Container(
                    width: Get.width/1.2,
                    height: Get.height/12,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: TextButton.icon(
                      icon:Icon(Icons.login,color: AppConstant.appTextColor,),
                      label: Text('Sign in with google',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16,fontFamily: AppConstant.appFontFamily),),
                      onPressed: () {
                        _googleSignInController.signInWithGoogle();
                      },
                    )
                ),
              ),
              SizedBox(
                height: Get.height/30,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
