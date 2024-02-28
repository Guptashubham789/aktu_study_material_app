import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../constant/app-constant.dart';
class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;
  //final String image;
  const HeadingWidget({super.key,
    required this.headingTitle,
    required this.headingSubTitle,
    required this.onTap,
    //required this.image,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headingTitle,
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    )),
                Text(headingSubTitle,
                    style:TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 8.0,
                      color: Colors.grey.shade800,
                    )
                ),
              ],
            ),
            //Lottie.asset(image,height: 50,width: 50),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: Get.height/18,
                width: Get.width/4,

                child: Card(
                  color: AppConstant.appSecondaryColor,
                  elevation: 10,
                  child: Center(
                    child: Text(buttonText,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: AppConstant.appTextColor,
                      fontFamily: AppConstant.appFontFamily
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
