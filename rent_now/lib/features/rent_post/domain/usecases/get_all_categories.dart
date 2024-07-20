import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/domain/repository/rent_post_repo.dart';

class GetAllCategories
    implements UseCase<List<CategoryModel>, GetAllCategoriesParams> {
  final RentPostRepo _rentPostRepo;

  GetAllCategories({required RentPostRepo rentPostRepo})
      : _rentPostRepo = rentPostRepo;

  @override
  Future<Either<Failure, List<CategoryModel>>> call(
      GetAllCategoriesParams params) async {
    return await _rentPostRepo.getAllCategory(token: params.token);
  }
}

class GetAllCategoriesParams {
  final String token;

  GetAllCategoriesParams({required this.token});
}
