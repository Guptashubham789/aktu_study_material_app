

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../constant/app-constant.dart';
import '../views/user/single-user-doc-screen.dart';


class AddDocumentWidget extends StatefulWidget {
  const AddDocumentWidget({super.key});

  @override
  State<AddDocumentWidget> createState() => _AddDocumentWidgetState();
}

class _AddDocumentWidgetState extends State<AddDocumentWidget> {

  User? user=FirebaseAuth.instance.currentUser;
  final firebasefirestore=FirebaseFirestore.instance;
  Reference storage=FirebaseStorage.instance.ref('userDocument');
  FirebaseStorage firebasestorage=FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  TextEditingController titlecontroller=TextEditingController();
  File? imageUrl;

  Future getImage() async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;

    final imageTemporary=File(image.path);
    setState(() {
      this.imageUrl=imageTemporary;
    });

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Upload Document',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: imageUrl!=null?Image.file(imageUrl!,width: 400,height: 400,fit: BoxFit.cover,):
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.yellow,
                  child: InkWell(
                      onTap: () async{
                        await getImage();
                      },
                      child: Icon(Icons.camera_alt)),
                ),
              ),
            ),
            SizedBox(height: 20,),
            //RoundButton(title:Icon(), onPress: onPress)
            Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: titlecontroller,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Qualification ',
                          hintText:'Enter the qualification name',
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: () async{
                    Get.snackbar(
                      "Please wait...",
                      "Hello users please wait 5 secound..",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppConstant.appSecondaryColor,
                      colorText: AppConstant.appTextColor,
                    );
                    String documentname=titlecontroller.text.trim();
                    try{
                      int date=DateTime.now().microsecondsSinceEpoch;
                      Reference ref=FirebaseStorage.instance.ref('userDocument/img$date');
                      UploadTask uploadeTask=ref.putFile(imageUrl!);
                      await Future.value(uploadeTask);
                      var newUrl=await ref.getDownloadURL();
                      Map<String,dynamic> postdegree={
                        'user_id':user!.uid,
                        'doc_id':date.toString(),
                        'createdAt':DateTime.now(),
                        'document_img':newUrl.toString(),
                        'document_name':documentname.toString(),
                      };
                      firebasefirestore.collection('userDocument').doc(date.toString()).set(postdegree);
                      EasyLoading.dismiss();
                      Get.snackbar(
                        "Document save success..",
                        "Your document uploaded in successfully",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appSecondaryColor,
                        colorText: AppConstant.appTextColor,
                      );

                      Get.to(()=>SinglUserDocScreen());
                    }catch(error){
                      Get.snackbar(
                        "Image not upload in storage",
                        "$error",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appSecondaryColor,
                        colorText: AppConstant.appTextColor,
                      );
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
