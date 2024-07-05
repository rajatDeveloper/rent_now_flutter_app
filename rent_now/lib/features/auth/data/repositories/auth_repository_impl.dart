import 'dart:convert';
import 'package:fpdart/fpdart.dart';

import 'package:rent_now/core/const/keys.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rent_now/features/auth/domain/entities/User.dart';
import 'package:rent_now/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String username, required String password}) async {
    try {
      var res = await authRemoteDataSource.loginWithEmailAndPassword(
          username: username, password: password);

      //save user data
      final userMap = jsonEncode(res.toMap());
      setDataToLocal(key: userKey, value: userMap);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(
      {required String username,
      required String email,
      required String password,
      required String password2}) async {
    try {
      var res = await authRemoteDataSource.registerWithEmailAndPassword(
          username: username,
          email: email,
          password: password,
          password2: password2);
      final userMap = jsonEncode(res.toMap());
      setDataToLocal(key: userKey, value: userMap);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}