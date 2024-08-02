import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:rent_now/core/error/exception.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/features/rent_post/data/datasources/rent_post_datasource.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/domain/repository/rent_post_repo.dart';

class RentPostRepoImpl implements RentPostRepo {
  final RentPostDatasource rentPostDatasource;

  RentPostRepoImpl(this.rentPostDatasource);

  @override
  Future<Either<Failure, List<RentPostModel>>> getAllRentPost(
      {required String category,
      required String pin_code,
      required String token}) async {
    try {
      var res = await rentPostDatasource.getAllRentPost(
          category: category, pin_code: pin_code, token: token);

      return right(res);
    } on ServerExceptionRentNow catch (e) {
      log(e.message);

      return left(Failure("Error: ${e.message}"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategory(
      {required String token}) async {
    try {
      var res = await rentPostDatasource.getAllCategory(token: token);

      return right(res);
    } on ServerExceptionRentNow catch (e) {
      log(e.message);

      return left(Failure("Error: ${e.message}"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RentPostModel>>> getMyRentPost(
      {required String token, required String userId}) async {
    try {
      var res =
          await rentPostDatasource.getMyRentPost(token: token, userId: userId);
      return right(res);
    } on ServerExceptionRentNow catch (e) {
      log(e.message);
      return left(Failure("Error: ${e.message}"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
