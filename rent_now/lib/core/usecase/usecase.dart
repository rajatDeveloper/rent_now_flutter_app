import 'package:fpdart/fpdart.dart';
import 'package:rent_now/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params parms);
}

class NoParms {}
