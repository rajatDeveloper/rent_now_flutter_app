import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/features/auth/domain/entities/User.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  //login with email and password
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String username, required String password});

  //register with email and password and username

  Future<Either<Failure, User>> registerWithEmailAndPassword(
      {required String username,
      required String email,
      required String password,
      required String password2});
}
