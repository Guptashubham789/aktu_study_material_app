// ignore_for_file: file_names

class YearModel {
  final String branch_id;
  final String degree_id;
  final String branch_name;
  final String year_id;
  final String year_name;
  final String year_img;

  final dynamic createdAt;


  YearModel({
    required this.branch_id,
    required this.degree_id,
    required this.branch_name,
    required this.year_id,
    required this.year_name,
    required this.year_img,
    required this.createdAt,

  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'branch_id': branch_id,
      'branch_name': branch_name,
      'year_id': year_id,
      'year_name': year_name,
      'year_img': year_img,
      'degree_id': degree_id,
      'createdAt': createdAt,

    };
  }

  // Create a UserModel instance from a JSON map
  factory YearModel.fromMap(Map<String, dynamic> json) {
    return YearModel(
      branch_id: json['branch_id'],
      branch_name: json['branch_name'],
      year_id: json['year_id'],
      year_name: json['year_name'],
      year_img: json['year_img'],
      degree_id: json['degree_id'],
      createdAt: json['createdAt'],

    );
  }
}