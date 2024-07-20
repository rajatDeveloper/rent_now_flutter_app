// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String token;
  final String username;
  final int id;
  final String email;

  UserModel({
    required this.token,
    required this.username,
    required this.id,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'username': username,
      'id': id,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] as String,
      username: map['username'] as String,
      id: map['id'] as int,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
