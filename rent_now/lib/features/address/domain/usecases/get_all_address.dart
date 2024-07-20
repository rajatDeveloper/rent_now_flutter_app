import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:rent_now/features/address/domain/repository/address_repo.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

class GetAllAddress implements UseCase<List<AddressModel>, GetAllAddressParms> {
  final AddressRepo addressRepo;
  GetAllAddress(this.addressRepo);
  @override
  Future<Either<Failure, List<AddressModel>>> call(
      GetAllAddressParms parms) async {
    return await addressRepo.getAllUserAddress(
        token: parms.token, userId: parms.userId);
  }
}

class GetAllAddressParms {
  final String token;
  final String userId;

  GetAllAddressParms({required this.token, required this.userId});
}
