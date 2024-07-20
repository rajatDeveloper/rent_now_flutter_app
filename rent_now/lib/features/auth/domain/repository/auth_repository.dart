import 'package:rent_now/core/error/failure.dart';

import 'package:fpdart/fpdart.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {
  //login with email and password
  Future<Either<Failure, UserModel>> loginWithEmailAndPassword(
      {required String username, required String password});

  //register with email and password and username

  Future<Either<Failure, UserModel>> registerWithEmailAndPassword(
      {required String username,
      required String email,
      required String password,
      required String password2});
}
