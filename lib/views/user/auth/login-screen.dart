import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../constant/app-constant.dart';
import '../../admin/admin-dash-screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userEmail=TextEditingController();
  TextEditingController userPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text("User Login",style: TextStyle(color: Colors.white,fontFamily: AppConstant.appFontFamily),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email",

                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top: 2,left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userPassword,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),

                        contentPadding: EdgeInsets.only(top: 2,left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),),
                ),


              SizedBox(
                height: Get.height/30,
              ),
              Material(
                child: Container(
                    width: Get.width/2,
                    height: Get.height/16,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: TextButton.icon(
                      icon: Icon(Icons.login,color: Colors.white,),
                      label: Text('Login',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16,fontFamily: AppConstant.appFontFamily),),
                      onPressed: (){
                        String name=userEmail.text.trim();
                        String password=userPassword.text.trim();
                        if(name=="7704050632" && password=="7704050632"){
                          Get.offAll(()=>AdminDashScreen());
                        }else{
                          print("Error");
                        }

                      },
                    )
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 14,fontFamily: AppConstant.appFontFamily)),
                  GestureDetector(onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    //     SignUpScreen()));
                  },
                      child: Text("SignUp",style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: AppConstant.appFontFamily))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
