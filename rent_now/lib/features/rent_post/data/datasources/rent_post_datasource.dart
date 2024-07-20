import 'dart:developer';

import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/network/api_constants.dart';
import 'package:rent_now/network/application_error.dart';
import 'package:rent_now/network/network_manager.dart';
import 'package:rent_now/network/network_request.dart';

abstract interface class RentPostDatasource {
  Future<List<RentPostModel>> getAllRentPost(
      {required String category,
      required String pin_code,
      required String token});

  Future<List<CategoryModel>> getAllCategory({required String token});
}

class RentPostDatasourceImpl implements RentPostDatasource {
  final BaseService base;

  RentPostDatasourceImpl(this.base);
  @override
  Future<List<RentPostModel>> getAllRentPost(
      {required String category,
      required String pin_code,
      required String token}) async {
    try {
      NetworkRequest request = NetworkRequest(
        allRentPostUrl,
        RequestMethod.get,
        queryParams: {
          "category": category,
          "address__pin_code": pin_code,
        },
        headers: base.getAuthorizationHeaders(token: token),
      );

      final result =
          await NetworkManager.instance.perform<List<RentPostModel>>(request);

      if (result.error != null) {
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }

      var dataMap = result.json;

      List<RentPostModel> rentPostList = [];
      dataMap.forEach((element) {
        rentPostList.add(RentPostModel.fromMap(element));
      });
      return rentPostList;
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
  Future<List<CategoryModel>> getAllCategory({required String token}) async {
    try {
      NetworkRequest request = NetworkRequest(
        allCategoryUrl,
        RequestMethod.get,
        headers: base.getAuthorizationHeaders(token: token),
      );

      final result =
          await NetworkManager.instance.perform<List<CategoryModel>>(request);

      if (result.error != null) {
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }

      var dataMap = result.json;

      List<CategoryModel> catList = [];
      dataMap.forEach((element) {
        catList.add(CategoryModel.fromMap(element));
      });
      return catList;
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
