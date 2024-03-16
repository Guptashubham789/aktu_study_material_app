

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constant/app-constant.dart';


class AddDocumentWidget extends StatefulWidget {
  const AddDocumentWidget({super.key});

  @override
  State<AddDocumentWidget> createState() => _AddDocumentWidgetState();
}

class _AddDocumentWidgetState extends State<AddDocumentWidget> {
  User? user=FirebaseAuth.instance.currentUser;
  final firebasefirestore=FirebaseFirestore.instance;
  // Reference storage=FirebaseStorage.instance.ref('degree');
  // FirebaseStorage firebasestorage=FirebaseStorage.instance;
  // final ImagePicker _picker = ImagePicker();
  TextEditingController titlecontroller=TextEditingController();
  File? imageUrl;

  // Future getImage() async{
  //  // final image=await ImagePicker().pickImage(source: ImageSource.gallery);
  //  // if(image==null) return;
  //
  //   final imageTemporary=File(image.path);
  //   setState(() {
  //     this.imageUrl=imageTemporary;
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    //dynamic s=absolute;
    var absolute;
    return  Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text("Upload degree",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),
        ),
        backgroundColor: Colors.blue[100],

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
                  color: Colors.blue[100],
                  child: InkWell(
                      onTap: () async{
                       // await getImage();
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
                          labelText: 'Degree name',
                          hintText:'Enter the degree name',
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
                  child: Text('Add Document'),
                  onPressed:(){}
              ),
            )
          ],
        ),
      ),
    );
  }
}
