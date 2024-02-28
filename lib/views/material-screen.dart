
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studymaterialapp/model/material-model.dart';
import 'package:studymaterialapp/views/all-branch-screen.dart';
import 'package:studymaterialapp/views/pdf-viewer-screen.dart';
import 'package:studymaterialapp/widget/degree-widget.dart';

import '../../constant/app-constant.dart';
import '../../model/degree-model.dart';

class MaterialScreen extends StatefulWidget {
  String year_id;
   MaterialScreen({super.key, required this.year_id});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Notes/Books',style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: StreamBuilder(stream:FirebaseFirestore.instance.collection('material').where('year_id',isEqualTo: widget.year_id).snapshots(),
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
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 0.70
                ),
                itemBuilder: (context,index) {
                  //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                  MaterialModel materialModel=MaterialModel(
                      branch_id: snapshot.data!.docs[index]['branch_id'],
                      degree_id: snapshot.data!.docs[index]['degree_id'],
                      year_id: snapshot.data!.docs[index]['year_id'],
                      year_name: snapshot.data!.docs[index]['year_name'],
                      material_name: snapshot.data!.docs[index]['material_name'],
                      material_id: snapshot.data!.docs[index]['material_id'],
                      material_url: snapshot.data!.docs[index]['material_url'],
                      branch_name: snapshot.data!.docs[index]['branch_name'],
                      degree_name: snapshot.data!.docs[index]['degree_name'],
                      createdAt: snapshot.data!.docs[index]['createdAt']

                  );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),


                                child: Stack(
                                  children:[ Container(

                                    decoration: BoxDecoration(
                                        color: Colors.yellow[50],
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              Get.to(()=>PdfViewerScreen(material_url:materialModel.material_url));
                                            },
                                            child: Image.asset("assets/img/pdficon.png",height: 150,width: 200,)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              Text(materialModel.material_name,style: TextStyle(fontFamily: AppConstant.appFontFamily,fontSize: 10,color: AppConstant.appTextColor),maxLines: 2,),
                                              GestureDetector(
                                                  onTap: () async{
                                                    Map<Permission, PermissionStatus> statuses = await [
                                                      Permission.storage,
                                                      //add more permission to request here.
                                                    ].request();

                                                    if(statuses[Permission.storage]!.isGranted){
                                                      var dir = await DownloadsPathProvider.downloadsDirectory;
                                                      if(dir != null){
                                                        String basename = materialModel.material_name;
                                                        String savePath = "${dir.path}/$basename";
                                                        print(savePath);
                                                        //output:  /storage/emulated/0/Download/banner.png

                                                        try {
                                                          await Dio().download(
                                                              materialModel.material_url,
                                                              savePath,
                                                              onReceiveProgress: (received, total) {
                                                                if (total != -1) {
                                                                  print((received / total * 100).toStringAsFixed(0) + "%");
                                                                  //you can build progressbar feature too
                                                                }
                                                              });
                                                          print("File is saved to download folder.");
                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                            content: Text("File Downloaded"),
                                                          ));
                                                        } on DioError catch (e) {
                                                          print(e.message);
                                                        }
                                                      }
                                                    }else{
                                                      print("No permission to read and write.");
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        content: Text("Permission Denied !"),
                                                      ));
                                                    }
                                                  },
                                                child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.amberAccent,
                                                        borderRadius: BorderRadius.circular(25)
                                                    ),

                                                    child: const Icon(Icons.download,)),
                                              ),
                                            ],
                                          ),
                                        )

                                      ],
                                    )
                                  ),


    ]
                                ),


                  );
                },

              );

            }

            return Container();
          }
      ),
    );
  }
}
