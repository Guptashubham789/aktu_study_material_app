import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studymaterialapp/views/contacts-screen.dart';
import 'package:studymaterialapp/views/user/UserDashScreen.dart';

import '../constant/app-constant.dart';
import '../views/user/auth/user-main-screen.dart';
import '../views/user/profile-screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});


  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final user=FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: Get.height/25),
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
        ),
        child: Wrap(
          runSpacing: 5,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Dr. A.P.J. Abdul Kalam Technical University',style: TextStyle(color: AppConstant.appTextColor),),
                leading: Container(
                  height: 100,
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: AppConstant.appSecondaryColor,
                    child: Image.network('https://www.careerguide.com/career/wp-content/uploads/2023/08/Dr.-A.P.J.-Abdul-Kalam-Technical-University-min-300x225.jpg'),
                  ),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(()=>UserDashScreen());

                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Home',style: TextStyle(color: AppConstant.appTextColor),),
                leading: Icon(Icons.home,color: AppConstant.appTextColor,),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(()=>ProfileScreen(user:user));

                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Profile',style: TextStyle(color: AppConstant.appTextColor),),
                leading: Icon(Icons.person,color: AppConstant.appTextColor,),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: (){
                  Get.to(()=>ContactsScreen());

                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Contact Me',style: TextStyle(color: AppConstant.appTextColor),),
                leading: Icon(Icons.contacts,color: AppConstant.appTextColor,),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn=GoogleSignIn();
                  FirebaseAuth _auth=FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(()=>WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Logout',style: TextStyle(color: AppConstant.appTextColor),),
                leading: Icon(Icons.logout,color: AppConstant.appTextColor,),
                trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appSecondaryColor,
      ),
    );
  }
}