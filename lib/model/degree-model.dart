// ignore_for_file: file_names

class DegreeModel {
  final String degree_id;
  final String degree_img;
  final String degree_name;
  final dynamic createdAt;
 

  DegreeModel({
    required this.degree_id,
    required this.degree_img,
    required this.degree_name,
    required this.createdAt,
   
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'degree_id': degree_id,
      'degree_img': degree_img,
      'categoryName': degree_name,
      'createdAt': createdAt,
     
    };
  }

  // Create a UserModel instance from a JSON map
  factory DegreeModel.fromMap(Map<String, dynamic> json) {
    return DegreeModel(
      degree_id: json['degree_id'],
      degree_img: json['degree_img'],
      degree_name: json['degree_name'],
      createdAt: json['createdAt'],
     
    );
  }
}