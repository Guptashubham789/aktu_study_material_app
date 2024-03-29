import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:studymaterialapp/model/aktu-website-model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/degree-model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _launchURL(String aktuurl) async {
      String link=aktuurl;
      final Uri url = Uri.parse(link.toString());
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
    return FutureBuilder(future:FirebaseFirestore.instance.collection('aktuofficial').get(),
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
              child: Text('No categories found!!'),
            );
          }
          //
          if(snapshot.data!=null){
            return Container(
              height: Get.height/8,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                    AktuWebsiteModel degreeModel=AktuWebsiteModel(
                        id: snapshot.data!.docs[index]['id'],
                        img: snapshot.data!.docs[index]['img'],
                        name: snapshot.data!.docs[index]['name'],
                        url: snapshot.data!.docs[index]['url'],
                        createdAt: snapshot.data!.docs[index]['createdAt']
                    );
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            String url=degreeModel.url;
                            _launchURL(url);
                          },
                          child: Padding(padding: EdgeInsets.all(10.0),
                            child: Container(
                              //height: Get.height/,
                              child: TransparentImageCard(
                                borderRadius: 10.0,
                                width: Get.width/4.0,
                                height: Get.height/8,
                                imageProvider: CachedNetworkImageProvider(degreeModel.img),
                                title: Center(child: Text(degreeModel.name,style: TextStyle(color: Colors.white,fontSize: 8.0),)) ,

                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  }),
            );
          }

          return Container();
        }
    );
  }
}