import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/app-constant.dart';
import '../user/auth/user-main-screen.dart';

class AdminDashScreen extends StatefulWidget {
  const AdminDashScreen({super.key});

  @override
  State<AdminDashScreen> createState() => _AdminDashScreenState();
}

class _AdminDashScreenState extends State<AdminDashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: AppConstant.appSecondaryColor,
        title: Center(child: Text('Admin Dash',style: TextStyle(fontSize: 18),)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async{
                // GoogleSignIn googleSignIn=GoogleSignIn();
                // FirebaseAuth _auth=FirebaseAuth.instance;
                // await _auth.signOut();
                // await googleSignIn.signOut();
                Get.offAll(()=>WelcomeScreen());
              },),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                //child: Image.asset('assets/img/'),
              ),
              Text("Shubham Gupta"),
              Text("sg731159@gmail.com"),
              GridView.builder(
                shrinkWrap: true,
                  primary: false,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,
                  itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        color: AppConstant.appSecondaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(""),
                            Text("")
                          ],
                        ),
                      ),
                    );

                  }
              )
            ],
          ),
        ),
      ),
    );
  }
  static final List<Map<String,dynamic>> dashboardItem=[
    {
      "title":"5",
      "Subtitle":"User",
    },
    {
      "title":"10",
      "Subtitle":"Degree",
    },
    {
      "title":"20",
      "Subtitle":"Branch",
    },
    {
      "title":"4",
      "Subtitle":"Years",
    },
    {
      "title":"100",
      "Subtitle":"Material",
    },
  ];
}
