
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
import 'package:studymaterialapp/model/year-model.dart';
import 'package:studymaterialapp/widget/degree-widget.dart';

import '../../constant/app-constant.dart';
import '../../model/degree-model.dart';
import 'material-screen.dart';

class AllBranchYearScreen extends StatefulWidget {
  String branch_id;
  AllBranchYearScreen({super.key,required String this.branch_id});

  @override
  State<AllBranchYearScreen> createState() => _AllBranchYearScreenState();
}

class _AllBranchYearScreenState extends State<AllBranchYearScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Year',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: StreamBuilder(stream:FirebaseFirestore.instance.collection('years').where('branch_id',isEqualTo: widget.branch_id).snapshots(),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 1.50
                ),
                itemBuilder: (context,index) {
                  //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                  //
                  final productData=snapshot.data!.docs[index];
                  YearModel yearModel=YearModel(
                      branch_id: snapshot.data!.docs[index]['branch_id'],
                      degree_id: snapshot.data!.docs[index]['degree_id'],
                      year_id: snapshot.data!.docs[index]['year_id'],
                      year_name: snapshot.data!.docs[index]['year_name'],
                      year_img: snapshot.data!.docs[index]['year_img'],
                      branch_name: snapshot.data!.docs[index]['branch_name'],
                      createdAt: snapshot.data!.docs[index]['createdAt']
                  );
                  return SizedBox(
                    height: Get.height/1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>MaterialScreen(year_id:yearModel.year_id));
                          },
                          child: Card(
                            elevation: 10,
                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 1.1,
                              heightImage: Get.height /4,
                              imageProvider: CachedNetworkImageProvider(
                                  yearModel.year_img),
                              title: const Center(child: Text("Click Here",
                                style: TextStyle(color: Colors.black87, fontSize: 8.0,fontFamily: "serif"),)),

                            ),
                          ),
                          ),


                      ],
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
