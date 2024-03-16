import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app-constant.dart';

class AddDocumentWidget extends StatefulWidget {
  const AddDocumentWidget({super.key});

  @override
  State<AddDocumentWidget> createState() => _AddDocumentWidgetState();
}

class _AddDocumentWidgetState extends State<AddDocumentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Document',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.black87,
        foregroundColor: Colors.white,
        mini: true,
        onPressed: () {
          Get.to(()=>AddDocumentWidget());
        },
        child: Container(
          child:
              Icon(Icons.photo)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Hello user apload this document and save your documents anytime.!!')
          ],
        ),
      ),
    );
  }
}
