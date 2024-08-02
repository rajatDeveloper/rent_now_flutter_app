import 'package:fpdart/src/either.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';
import 'package:rent_now/features/rent_request/data/datasources/rent_request_type_datasource.dart';
import 'package:rent_now/features/rent_request/domain/repository/rent_rerquest_type_repo.dart';

class RentRequestRepoImpl implements RentRequestTypeRepo {
  final RentRequestTypeDatasource rentRequestType;

  RentRequestRepoImpl(this.rentRequestType);
  @override
  Future<Either<Failure, RentRequestModel>> createRentRequestType(
      {required String token,
      required String rentType,
      required double payPerDuration}) async {
    try {
      var res = await rentRequestType.createRentRequestType(
          token: token, rentType: rentType, payPerDuration: payPerDuration);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
