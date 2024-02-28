
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:studymaterialapp/views/all-branch-screen.dart';
import 'package:studymaterialapp/widget/degree-widget.dart';

import '../../constant/app-constant.dart';
import '../../model/degree-model.dart';

class AllDegreeScreen extends StatefulWidget {
  const AllDegreeScreen({super.key});

  @override
  State<AllDegreeScreen> createState() => _AllDegreeScreenState();
}

class _AllDegreeScreenState extends State<AllDegreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Degree',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: StreamBuilder(stream:FirebaseFirestore.instance.collection('degree').snapshots(),
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
                child: Text('No degree found!!'),
              );
            }
            //
            if(snapshot.data!=null){
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 1.19
                ),
                itemBuilder: (context,index) {
                  //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                  DegreeModel degreeModel=DegreeModel(
                      degree_id: snapshot.data!.docs[index]['degree_id'],
                      degree_img: snapshot.data!.docs[index]['degree_img'],
                      degree_name: snapshot.data!.docs[index]['degree_name'],
                      createdAt: snapshot.data!.docs[index]['createdAt']
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>AllBranchScreen(degree_id:degreeModel.degree_id));
                        },
                        child: Padding(padding: EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 5,
                            child: Container(

                              child: FillImageCard(
                                borderRadius: 20.0,
                                width: Get.width / 2.5,
                                heightImage: Get.height / 10,
                                imageProvider: CachedNetworkImageProvider(
                                    degreeModel.degree_img),
                                title: Center(child: Text(degreeModel.degree_name,
                                  style: TextStyle(color: Colors.black87, fontSize: 10.0,fontFamily: "serif"),)),

                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
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
