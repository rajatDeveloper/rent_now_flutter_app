import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  //  "category": {
  //           "id": 1,
  //           "name": "Flat",
  //           "description": "test",
  //           "category_image": "http://rentnow2023.pythonanywhere.com/media/category_images/WhatsApp_Image_2024-05-27_at_3.43.09_PM.jpeg"
  //       },

  final int id;
  final String name;
  final String description;
  final String category_image;
  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category_image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'category_image': category_image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      category_image: map['category_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
