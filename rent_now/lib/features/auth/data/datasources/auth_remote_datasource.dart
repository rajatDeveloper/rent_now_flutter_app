//interface

import 'dart:convert';
import 'dart:developer';

import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';
import 'package:rent_now/network/api_constants.dart';
import 'package:rent_now/network/network_manager.dart';
import 'package:rent_now/network/network_request.dart';

abstract interface class AuthRemoteDataSource {
  // interface function for login with email and password
  Future<UserModel> loginWithEmailAndPassword(
      {required String username, required String password});

  // interface function for register with email and password

  Future<UserModel> registerWithEmailAndPassword(
      {required String username,
      required String email,
      required String password,
      required String password2});
}

// We are going to impelement this interface in the data source layer

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final BaseService base;

  AuthRemoteDatasourceImpl(this.base);

  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String username, required String password}) async {
    try {
      var data = {
        "username": username,
        "password": password,
      };

      NetworkRequest request = NetworkRequest(
        "$loginUrl",
        RequestMethod.post,
        data: jsonEncode(data),
        headers: base.getHeaders(),
      );

      final result = await NetworkManager.instance.perform<UserModel>(request);
      log("Error : ${result.error!.errorMsg}");
      if (result.json != null) {
        var userMap = result.json;

        return UserModel.fromJson(userMap);
      } else {
        throw const ServerException("Server Error");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword(
      {required String username,
      required String email,
      required String password,
      required String password2}) async {
    try {
      var data = {
        "username": username,
        "email": email,
        "password": password,
        "password2": password2
      };

      NetworkRequest request = NetworkRequest(
        "$registerUrl",
        RequestMethod.post,
        data: jsonEncode(data),
        headers: base.getHeaders(),
      );

      final result = await NetworkManager.instance.perform<UserModel>(request);

      if (result.json != null) {
        var userMap = result.json;

        return UserModel.fromJson(userMap);
      } else {
        throw const ServerException("Server Error");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
