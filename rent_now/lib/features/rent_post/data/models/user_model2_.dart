// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel2 {
  //       "user": {
  //           "id": 4,
  //           "username": "rajat_test",
  //           "email": "test1@gmail.com"
  //       },

  final int id;
  final String username;
  final String email;

  UserModel2({
    required this.id,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
    };
  }

  factory UserModel2.fromMap(Map<String, dynamic> map) {
    return UserModel2(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel2.fromJson(String source) =>
      UserModel2.fromMap(json.decode(source) as Map<String, dynamic>);
}
