import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/features/address/data/datasources/address_datasource.dart';
import 'package:rent_now/features/address/domain/repository/address_repo.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

class AddressRepoImpl implements AddressRepo {
  final AddressDataSource addressDataSource;

  AddressRepoImpl(this.addressDataSource);

  @override
  Future<Either<Failure, AddressModel>> createAddress(
      {required AddressModel addressInput, required String token}) async {
    try {
      var res = await addressDataSource.createAddress(
          addressInput: addressInput, token: token);

      //save user data

      return right(res);
    } on ServerExceptionRentNow catch (e) {
      log(e.message);
      return left(Failure("Error: ${e.message}"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAllUserAddress(
      {required String token, required String userId}) async {
    try {
      var res =
          await addressDataSource.getAddresses(token: token, userId: userId);

      return right(res);
    } on ServerExceptionRentNow catch (e) {
      log(e.message);
      return left(Failure("Error: ${e.message}"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
