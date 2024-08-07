import 'dart:convert';
import 'dart:developer';

import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';
import 'package:rent_now/network/api_constants.dart';
import 'package:rent_now/network/application_error.dart';
import 'package:rent_now/network/network_manager.dart';
import 'package:rent_now/network/network_request.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailAndPassword({
    required String username,
    required String password,
  });

  Future<UserModel> registerWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
    required String password2,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final BaseService base;

  AuthRemoteDatasourceImpl(this.base);

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      var data = {
        "username": username,
        "password": password,
      };

      NetworkRequest request = NetworkRequest(
        loginUrl,
        RequestMethod.post,
        data: jsonEncode(data),
        headers: base.getHeaders(),
      );

      final result = await NetworkManager.instance.perform<UserModel>(request);

      // Add log to print the result
      log("Login Response: ${result.json}");

      if (result.error != null) {
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }

      return UserModel.fromMap(result.json);
    } on ApplicationError catch (e) {
      throw ServerExceptionRentNow(e.errorMsg);
    } on ServerExceptionRentNow catch (e) {
      log("catch error ${e.toString()}");
      throw ServerExceptionRentNow(e.message);
    } catch (e) {
      throw ServerExceptionRentNow(e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
    required String password2,
  }) async {
    try {
      var data = {
        "username": username,
        "email": email,
        "password": password,
        "password2": password2,
      };

      NetworkRequest request = NetworkRequest(
        registerUrl,
        RequestMethod.post,
        data: jsonEncode(data),
        headers: base.getHeaders(),
      );

      final result = await NetworkManager.instance.perform<UserModel>(request);

      // Add log to print the result
      log("Register Response: ${result.json}");

      if (result.json != null && result.error == null) {
        return UserModel.fromMap(result.json);
      } else {
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }
    } on ApplicationError catch (e) {
      throw ServerExceptionRentNow(e.errorMsg);
    } on ServerExceptionRentNow catch (e) {
      throw ServerExceptionRentNow(e.message);
    } catch (e) {
      throw ServerExceptionRentNow(e.toString());
    }
  }
}
