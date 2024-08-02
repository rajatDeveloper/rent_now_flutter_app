import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';
import 'package:rent_now/features/rent_request/domain/repository/rent_rerquest_type_repo.dart';

class CreateRentRequestType
    implements UseCase<RentRequestModel, CreateRentRequestTypeParams> {
  final RentRequestTypeRepo repository;

  CreateRentRequestType(this.repository);

  @override
  Future<Either<Failure, RentRequestModel>> call(
      CreateRentRequestTypeParams params) async {
    return await repository.createRentRequestType(
        token: params.token,
        rentType: params.rentRequestType,
        payPerDuration: params.pricePerDuration);
  }
}

class CreateRentRequestTypeParams {
  final String token;
  final String rentRequestType;
  final double pricePerDuration;

  CreateRentRequestTypeParams(
      {required this.token,
      required this.rentRequestType,
      required this.pricePerDuration});
}
