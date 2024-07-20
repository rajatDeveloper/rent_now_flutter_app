import 'package:fpdart/src/either.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:rent_now/features/address/domain/repository/address_repo.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

class CreateUserAddress
    implements UseCase<AddressModel, CreateUserAddressParams> {
  final AddressRepo addressRepo;

  CreateUserAddress(this.addressRepo);
  @override
  Future<Either<Failure, AddressModel>> call(
      CreateUserAddressParams parms) async {
    return await addressRepo.createAddress(
        addressInput: parms.inputAddress, token: parms.token);
  }
}

class CreateUserAddressParams {
  final AddressModel inputAddress;
  final String token;

  CreateUserAddressParams({required this.inputAddress, required this.token});
}
