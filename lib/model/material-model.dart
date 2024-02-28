// ignore_for_file: file_names

class MaterialModel {
  final String branch_id;
  final String degree_id;
  final String branch_name;
  final String year_id;
  final String year_name;
  final String degree_name;
  final String material_id;
  final String material_name;
  final String material_url;

  final dynamic createdAt;


  MaterialModel({
    required this.branch_id,
    required this.degree_id,
    required this.branch_name,
    required this.degree_name,
    required this.year_id,
    required this.year_name,
    required this.material_url,
    required this.material_id,
    required this.material_name,
    required this.createdAt,

  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'branch_id': branch_id,
      'branch_name': branch_name,
      'year_id': year_id,
      'year_name': year_name,
      'material_url': material_url,
      'material_name': material_name,
      'material_id': material_id,
      'degree_name': degree_name,
      'degree_id': degree_id,
      'createdAt': createdAt,

    };
  }

  // Create a UserModel instance from a JSON map
  factory MaterialModel.fromMap(Map<String, dynamic> json) {
    return MaterialModel(
      branch_id: json['branch_id'],
      branch_name: json['branch_name'],
      year_id: json['year_id'],
      year_name: json['year_name'],
      material_url: json['material_url'],
      material_id: json['material_id'],
      material_name: json['year_img'],
      degree_name: json['material_name'],
      degree_id: json['degree_id'],
      createdAt: json['createdAt'],

    );
  }
}