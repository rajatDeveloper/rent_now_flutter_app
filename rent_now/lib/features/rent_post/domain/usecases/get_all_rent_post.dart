import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/domain/repository/rent_post_repo.dart';

class GetAllRentPost
    implements UseCase<List<RentPostModel>, GetAllRentPostParams> {
  final RentPostRepo _rentPostRepo;

  GetAllRentPost({required RentPostRepo rentPostRepo})
      : _rentPostRepo = rentPostRepo;

  @override
  Future<Either<Failure, List<RentPostModel>>> call(
      GetAllRentPostParams params) async {
    return await _rentPostRepo.getAllRentPost(
        category: params.category,
        pin_code: params.pin_code,
        token: params.token);
  }
}

class GetAllRentPostParams {
  final String category;
  final String pin_code;
  final String token;

  GetAllRentPostParams(
      {required this.category, required this.pin_code, required this.token});
}
