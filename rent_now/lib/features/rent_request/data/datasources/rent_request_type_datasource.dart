import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';
import 'package:rent_now/network/api_constants.dart';
import 'package:rent_now/network/application_error.dart';
import 'package:rent_now/network/network_manager.dart';
import 'package:rent_now/network/network_request.dart';

abstract interface class RentRequestTypeDatasource {
  Future<RentRequestModel> createRentRequestType(
      {required String token,
      required String rentType,
      required double payPerDuration});
}

class RentRequestTypeDatasourceImpl implements RentRequestTypeDatasource {
  final BaseService base;

  RentRequestTypeDatasourceImpl(this.base);

  @override
  Future<RentRequestModel> createRentRequestType(
      {required String token,
      required String rentType,
      required double payPerDuration}) async {
    try {
      NetworkRequest request = NetworkRequest(
        createRentRequestTypeUrl,
        RequestMethod.post,
        data: {
          "rent_type": rentType,
          "pay_per_duration": payPerDuration,
        },
        headers: base.getAuthorizationHeaders(token: token),
      );

      final result =
          await NetworkManager.instance.perform<RentRequestModel>(request);

      if (result.error != null) {
        throw ServerExceptionRentNow(result.error!.errorMsg);
      }

      return RentRequestModel.fromMap(result.json);
    } on ApplicationError catch (e) {
      throw ServerExceptionRentNow(e.errorMsg);
    } on ServerExceptionRentNow catch (e) {
      throw e;
    }
  }
}
