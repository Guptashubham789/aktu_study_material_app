class FeedbackModel{
  final String uId;
  final String username;
  final String useremail;
  final String usersubject;
  final String userMessage;
  final dynamic createdOn;


  FeedbackModel({
    required this.uId,
    required this.username,
    required this.useremail,
    required this.usersubject,
    required this.userMessage,

    required this.createdOn,

  });
  //Serialize the FeedbackModel instance to a JSON map

  Map<String,dynamic> toMap(){
    return {
      'uId':uId,
      'username':username,
      'useremail':useremail,


      'usersubject':usersubject,
      'userMessage':userMessage,

      'createdOn':createdOn,

    };
  }

  //create a FeedbackModel instance from a json map

  factory FeedbackModel.fromMap(Map<String,dynamic> json){
    return FeedbackModel(
      uId: json['uId'],
      username: json['username'],
      useremail: json['useremail'],
      usersubject: json['usersubject'],
      userMessage: json['userMessage'],

      createdOn: json['createdOn'],

    );
  }


}