import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:studymaterialapp/helpers/firebase-firestore.dart';

import '../model/user-model.dart';

class AppProvider with ChangeNotifier{
  List<UserModel> _userList=[];
  //ye jo getUserListFun hai ese hum helper ke ander bnayenge
  Future<void> getUserListFun() async{
    //helper class ke ander bnaye gaye method ko hum yha call karenge yh hume ek list return karke dega
    _userList =await FirebaseFirestoreHelper.instance.getUserList();
  }
  List<UserModel> get getUserList=>_userList;
}