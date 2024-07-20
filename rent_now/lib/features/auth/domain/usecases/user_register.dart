import 'package:rent_now/core/error/failure.dart';
import 'package:rent_now/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';

import 'package:rent_now/features/auth/domain/repository/auth_repository.dart';

class UserRegister implements UseCase<UserModel, UserRegisterParams> {
  final AuthRepository _authRepository;

  const UserRegister({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserModel>> call(UserRegisterParams parms) async {
    return await _authRepository.registerWithEmailAndPassword(
        username: parms.username,
        email: parms.email,
        password: parms.password,
        password2: parms.password2);
  }
}

class UserRegisterParams {
  final String username;
  final String email;
  final String password;
  final String password2;

  UserRegisterParams(
      {required this.username,
      required this.email,
      required this.password,
      required this.password2});
}
