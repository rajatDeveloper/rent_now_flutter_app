import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';

import 'package:rent_now/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<UserModel, UserLoginParams> {
  final AuthRepository _authRepository;

  const UserLogin({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserModel>> call(UserLoginParams params) async {
    return await _authRepository.loginWithEmailAndPassword(
        username: params.username, password: params.password);
  }
}

class UserLoginParams {
  final String username;
  final String password;

  UserLoginParams({required this.username, required this.password});
}
