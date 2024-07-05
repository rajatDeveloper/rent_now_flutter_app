// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String token;
  final String username;
  final int id;
  final String email;
  User({
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      username: map['username'] as String,
      id: map['id'] as int,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
