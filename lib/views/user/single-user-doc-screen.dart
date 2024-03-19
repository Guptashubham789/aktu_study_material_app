import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_card/image_card.dart';

import '../../constant/app-constant.dart';
import '../../controller/feedback-services.dart';
import '../../widget/userAdd-doc-widget.dart';
import 'dart:ui' as ui;
class SinglUserDocScreen extends StatefulWidget {
  const SinglUserDocScreen({super.key});

  @override
  State<SinglUserDocScreen> createState() => _SinglUserDocScreenState();
}

class _SinglUserDocScreenState extends State<SinglUserDocScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  double? _progress;
  final GlobalKey globalKey=GlobalKey();
  void shareImage(File imageFile){
    Share.share(imageFile.path.toString());
  }

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
            Icon(Icons.add)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text('Hello user upload this document and save your documents and you can access anytime.!!')),
                    ),
                    StreamBuilder(
                        stream:FirebaseFirestore.instance.collection('userDocument').where('user_id',isEqualTo: user!.uid).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          //agr koi error hai hmare snapshot me to yh condition chale
                          if(snapshot.hasError){
                            return Center(
                              child: Text('Error'),
                            );
                          }
                          //agr waiting me h to kya return kro
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Container(
                              height: Get.height/5.5,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                          }
                          // yani ki jo hum document ko fetch karna chah rhe h kya vh empty to nhi hai agr empty hai to yha par hum simple return karvayenge
                          if(snapshot.data!.docs.isEmpty){
                            return Center(
                              child: Image.asset('assets/img/coming_soon.png'),
                            );
                          }
                          //
                          if(snapshot.data!=null){
                            return  ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index) {
                                  //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                                  final data=snapshot.data!.docs[index];
                                  final dataurl=snapshot.data!.docs[index]['document_img'];

                                  return Expanded(
                                    child: SizedBox(
                                      height: Get.height/1.5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                           Card(
                                              elevation: 10,
                                              child: FillImageCard(
                                                borderRadius: 20.0,
                                                width: Get.width / 1.1,
                                                heightImage: Get.height /2,
                                                imageProvider: CachedNetworkImageProvider(
                                                    snapshot.data!.docs[index]['document_img']),
                                                title: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(snapshot.data!.docs[index]['doc_id']),
                                                     InkWell(
                                                        onTap: () async{
                                                          //shareImage(snapshot.data!.docs[index]['document_img']);
                                                          Share.share(snapshot.data!.docs[index]['document_img'].toString());
                                                        },
                                                        child: Icon(Icons.share)),
                                                    InkWell(
                                                      onTap: () {
                                                          deleteDocument(snapshot.data!.docs[index]['doc_id']);
                                                      },
                                                        child: Icon(Icons.delete))
                                                  ],
                                                ),

                                              ),
                                            ),
                                    
                                    
                                    
                                        ],
                                      ),
                                    ),
                                  );
                                },
        
                              );
                          }
        
                          return Container();
                        }
                    ),
                  ],
                ),
              ),
            
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }

}
