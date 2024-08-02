import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';

abstract interface class RentRequestTypeRepo {
  Future<Either<Failure, RentRequestModel>> createRentRequestType(
      {required String token,
      required String rentType,
      required double payPerDuration});
}
