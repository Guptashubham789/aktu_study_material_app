import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymaterialapp/model/user-model.dart';

class FirebaseFirestoreHelper{
  static FirebaseFirestoreHelper instance=FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  Future<List<UserModel>> getUserList() async{
   QuerySnapshot<Map<String,dynamic>> querySnapshot=await _firebaseFirestore.collection('users').get();
   return querySnapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }
}