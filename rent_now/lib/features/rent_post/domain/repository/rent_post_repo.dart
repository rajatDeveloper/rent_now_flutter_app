// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';

abstract interface class RentPostRepo {
  Future<Either<Failure, List<RentPostModel>>> getAllRentPost(
      {required String category,
      required String pin_code,
      required String token});

  Future<Either<Failure, List<CategoryModel>>> getAllCategory(
      {required String token});
}
