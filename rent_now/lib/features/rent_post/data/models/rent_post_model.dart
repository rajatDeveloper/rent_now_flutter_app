// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rent_now/features/rent_post/data/models/address_model.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';
import 'package:rent_now/features/rent_post/data/models/user_model2_.dart';

class RentPostModel {
  // {
  //       "id": 3,
  //       "user": {
  //           "id": 4,
  //           "username": "rajat_test",
  //           "email": "test1@gmail.com"
  //       },
  //       "category": {
  //           "id": 1,
  //           "name": "Flat",
  //           "description": "test",
  //           "category_image": "http://rentnow2023.pythonanywhere.com/media/category_images/WhatsApp_Image_2024-05-27_at_3.43.09_PM.jpeg"
  //       },
  //       "address": {
  //           "id": 1,
  //           "address": "bal sath colony",
  //           "pin_code": 136027,
  //           "city": "Kaithal",
  //           "state": "Haryana",
  //           "country": "India",
  //           "latitude": 78907.0,
  //           "longitude": 9898.0,
  //           "user": 3
  //       },
  //       "rent_request": [
  //           {
  //               "id": 1,
  //               "rent_type": "one_week",
  //               "pay_per_duration": 1000.0
  //           },
  //           {
  //               "id": 2,
  //               "rent_type": "one_week",
  //               "pay_per_duration": 12000.0
  //           }
  //       ],
  //       "title": "Test Rajat Single Model",
  //       "description": "klklj jnm,n mn",
  //       "post_image": "http://rentnow2023.pythonanywhere.com/media/post_images/Screenshot_2023-03-06_213955.png",
  //       "created_at": "2024-06-23T12:35:24.690779Z",
  //       "updated_at": "2024-06-24T04:44:38.303755Z",
  //       "whatsapp_number": "878768789798",
  //       "phone_number": "8768768678",
  //       "term_and_condition": "kjhjk hj hj"
  //   },

  final int id;
  final UserModel2 user;
  final CategoryModel category;
  final AddressModel address;
  final List<RentRequestModel> rent_request;
  final String title;
  final String description;
  final String post_image;
  final String created_at;
  final String updated_at;
  final String whatsapp_number;
  final String phone_number;
  final String term_and_condition;

  RentPostModel({
    required this.id,
    required this.user,
    required this.category,
    required this.address,
    required this.rent_request,
    required this.title,
    required this.description,
    required this.post_image,
    required this.created_at,
    required this.updated_at,
    required this.whatsapp_number,
    required this.phone_number,
    required this.term_and_condition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'category': category.toMap(),
      'address': address.toMap(),
      'rent_request': rent_request.map((x) => x.toMap()).toList(),
      'title': title,
      'description': description,
      'post_image': post_image,
      'created_at': created_at,
      'updated_at': updated_at,
      'whatsapp_number': whatsapp_number,
      'phone_number': phone_number,
      'term_and_condition': term_and_condition,
    };
  }

  factory RentPostModel.fromMap(Map<String, dynamic> map) {
    return RentPostModel(
      id: map['id'] as int,
      user: UserModel2.fromMap(map['user'] as Map<String, dynamic>),
      category: CategoryModel.fromMap(map['category'] as Map<String, dynamic>),
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      rent_request: List<RentRequestModel>.from(
        (map['rent_request'] as List<dynamic>).map<RentRequestModel>(
          (x) => RentRequestModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      title: map['title'] as String,
      description: map['description'] as String,
      post_image: map['post_image'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      whatsapp_number: map['whatsapp_number'] as String,
      phone_number: map['phone_number'] as String,
      term_and_condition: map['term_and_condition'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentPostModel.fromJson(String source) =>
      RentPostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
