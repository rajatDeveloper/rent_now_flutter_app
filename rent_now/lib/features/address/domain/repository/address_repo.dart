import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';

import 'package:rent_now/features/rent_post/data/models/address_model.dart';

abstract interface class AddressRepo {
  Future<Either<Failure, AddressModel>> createAddress(
      {required AddressModel addressInput, required String token});

  Future<Either<Failure, List<AddressModel>>> getAllUserAddress(
      {required String token, required String userId});
}
