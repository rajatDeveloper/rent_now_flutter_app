import 'package:rent_now/features/auth/domain/entities/User.dart';

class UserModel extends User {
  UserModel(
      {required super.token,
      required super.username,
      required super.id,
      required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      username: json['username'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
