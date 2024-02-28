// ignore_for_file: file_names

class BranchModel {
  final String branch_id;
  final String degree_id;
  final String branch_img;
  final String branch_name;
  final String degree_name;
  final dynamic createdAt;


  BranchModel({
    required this.branch_id,
    required this.branch_img,
    required this.degree_id,
    required this.degree_name,
    required this.branch_name,
    required this.createdAt,

  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'branch_id': branch_id,
      'branch_img': branch_img,
      'branch_name': branch_name,
      'degree_id': degree_id,
      'degree_name': degree_name,
      'createdAt': createdAt,

    };
  }

  // Create a UserModel instance from a JSON map
  factory BranchModel.fromMap(Map<String, dynamic> json) {
    return BranchModel(
      branch_id: json['branch_id'],
      branch_img: json['branch_img'],
      branch_name: json['branch_name'],
      degree_id: json['degree_id'],
      degree_name: json['degree_name'],
      createdAt: json['createdAt'],

    );
  }
}