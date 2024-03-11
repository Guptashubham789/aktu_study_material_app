// ignore_for_file: file_names

class AktuWebsiteModel {
  final String id;
  final String img;
  final String name;
  final String url;
  final dynamic createdAt;


  AktuWebsiteModel({
    required this.id,
    required this.img,
    required this.name,
    required this.url,
    required this.createdAt,

  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'img': img,
      'name': name,
      'url': url,
      'createdAt': createdAt,

    };
  }

  // Create a UserModel instance from a JSON map
  factory AktuWebsiteModel.fromMap(Map<String, dynamic> json) {
    return AktuWebsiteModel(
      id: json['id'],
      img: json['img'],
      name: json['name'],
      url: json['url'],
      createdAt: json['createdAt'],

    );
  }
}