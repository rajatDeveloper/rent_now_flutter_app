import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';

import 'package:rent_now/core/const/keys.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';

import 'package:rent_now/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> loginWithEmailAndPassword(
      {required String username, required String password}) async {
    try {
      var res = await authRemoteDataSource.loginWithEmailAndPassword(
          username: username, password: password);

      StaticData.user = res;

      //save user data
      final userMap = jsonEncode(res.toMap());

      setDataToLocal(key: userKey, value: userMap);

      return right(res);
    } on ServerExceptionRentNow catch (e) {
      log(e.message);
      return left(Failure("Error: ${e.message}"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerWithEmailAndPassword(
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
      StaticData.user = res;
      final userMap = jsonEncode(res.toMap());
      setDataToLocal(key: userKey, value: userMap);

      return right(res);
    } on ServerExceptionRentNow catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
