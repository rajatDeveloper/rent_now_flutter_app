import 'dart:developer';

import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';
import 'package:rent_now/network/application_error.dart';
import 'package:rent_now/network/network_manager.dart';
import 'package:rent_now/network/network_request.dart';

abstract interface class AddressDataSource {
  Future<List<AddressModel>> getAddresses(
      {required String token, required String userId});

  Future<AddressModel> createAddress(
      {required AddressModel addressInput, required String token});
}

class AddressDataSourceImpl implements AddressDataSource {
  final BaseService base;

  AddressDataSourceImpl(this.base);
  @override
  Future<AddressModel> createAddress(
      {required AddressModel addressInput, required String token}) async {
    try {
      var data = {
        "address": addressInput.address,
        "pin_code": addressInput.pin_code,
        "city": addressInput.city,
        "state": addressInput.state,
        "country": addressInput.country,
        "latitude": addressInput.latitude,
        "longitude": addressInput.longitude
      };

      NetworkRequest request = NetworkRequest(
        "users/${addressInput.user}/addresses/",
        RequestMethod.post,
        data: data,
        headers: base.getAuthorizationHeaders(token: token),
      );

      final result =
          await NetworkManager.instance.perform<AddressModel>(request);

      if (result.error != null) {
        log("I am here");
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }

      var addressMap = result.json;

      return AddressModel.fromMap(addressMap);
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
  Future<List<AddressModel>> getAddresses(
      {required String token, required String userId}) async {
    try {
      NetworkRequest request = NetworkRequest(
        "users/$userId/addresses/",
        RequestMethod.get,
        headers: base.getAuthorizationHeaders(token: token),
      );

      final result =
          await NetworkManager.instance.perform<List<AddressModel>>(request);

      if (result.error != null) {
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }

      var dataMap = result.json;

      List<AddressModel> dataList = [];
      dataMap.forEach((element) {
        dataList.add(AddressModel.fromMap(element));
      });
      return dataList;
    } on ApplicationError catch (e) {
      throw ServerExceptionRentNow(e.errorMsg);
    } on ServerExceptionRentNow catch (e) {
      log("catch error ${e.toString()}");
      throw ServerExceptionRentNow(e.message);
    } catch (e) {
      throw ServerExceptionRentNow(e.toString());
    }
  }
}
