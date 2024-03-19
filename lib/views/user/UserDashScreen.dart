
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studymaterialapp/constant/app-constant.dart';
import 'package:studymaterialapp/views/user/all-degree-screen.dart';
import 'package:studymaterialapp/widget/banner-widget.dart';

import '../../widget/aktu-website-widget.dart';
import '../../widget/degree-widget.dart';
import '../../widget/drawer-widget.dart';
import '../../widget/heading-title-widget.dart';
import 'auth/user-main-screen.dart';

class UserDashScreen extends StatefulWidget {
  const UserDashScreen({super.key});

  @override
  State<UserDashScreen> createState() => _UserDashScreenState();
}

class _UserDashScreenState extends State<UserDashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text('Aktu Notes/Book',style: TextStyle(fontSize: 18),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.message),
                Text('1',style: TextStyle(color: Colors.red,fontFamily: AppConstant.appFontFamily,fontSize: 12),)
              ],
            ),
            onPressed: () async{

              //Get.offAll(()=>WelcomeScreen());
            },),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: BannerWidget(),
              ),
              HeadingWidget(
                  headingTitle: "Aktu Website",
                  headingSubTitle: "Aktu official website is available here.." ,
                  onTap: (){
                    //Get.to(()=>AllDegreeScreen());
                  },
                  buttonText: "Link"
              ),
              CategoriesWidget(),
              HeadingWidget(
                  headingTitle: "Degree",
                  headingSubTitle: "All degree vise notes and book available here.." ,
                  onTap: (){
                    Get.to(()=>AllDegreeScreen());
                  },
                  buttonText: "Click Here"
              ),
              DegreeWidget()
            ],
          ),
        ),
      ),
    );
  }
}
