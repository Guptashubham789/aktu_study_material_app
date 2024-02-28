class UserModel{
  final String uId;
  final String username;
  final String useremail;
  final String userImg;
  final String userDeviceToken;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;


  UserModel({
    required this.uId,
    required this.username,
    required this.useremail,
    required this.userImg,
    required this.userDeviceToken,
    required this.isActive,
    required this.isAdmin,
    required this.createdOn,
  });
  //Serialize the UserModel instance to a JSON map

  Map<String,dynamic> toMap(){
    return {
      'uId':uId,
      'username':username,
      'useremail':useremail,
      'userImg':userImg,
      'userDeviceToken':userDeviceToken,
      'isAdmin': isAdmin,
      'isActive':isActive,
      'createdOn':createdOn,
    };
  }

  //create a UserModel instance from a json map

  factory UserModel.fromMap(Map<String,dynamic> json){
    return UserModel(
        uId: json['uId'],
        username: json['username'],
        useremail: json['useremail'],
        userImg: json['userImg'],
        userDeviceToken: json['userDeviceToken'],
        isActive: json['isActive'],
        isAdmin: json['isAdmin'],
        createdOn: json['createdOn'],
    );
  }


}