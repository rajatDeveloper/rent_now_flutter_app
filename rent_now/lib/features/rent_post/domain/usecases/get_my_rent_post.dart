import 'package:fpdart/src/either.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/domain/repository/rent_post_repo.dart';

class GetMyRentPost
    implements UseCase<List<RentPostModel>, GetMyRentPostParams> {
  final RentPostRepo _rentPostRepo;

  GetMyRentPost({required RentPostRepo rentPostRepo})
      : _rentPostRepo = rentPostRepo;

  @override
  Future<Either<Failure, List<RentPostModel>>> call(
      GetMyRentPostParams parms) async {
    return await _rentPostRepo.getMyRentPost(
        token: parms.token, userId: parms.userId);
  }
}

class GetMyRentPostParams {
  final String token;
  final String userId;

  GetMyRentPostParams({required this.token, required this.userId});
}
