import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
//multidash board handle for example user and admin screen
class GetUserDataController extends GetxController{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;


  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uId) async{
    final QuerySnapshot userData=
    await _firestore.collection('users').where('uId',isEqualTo: uId).get();
    return userData.docs;
  }
  Future<List<QueryDocumentSnapshot<Object?>>> getUserDeviceToken(String uId) async{
    final QuerySnapshot userDeviceToken=
    await _firestore.collection('users').get();
    return userDeviceToken.docs;
  }

}