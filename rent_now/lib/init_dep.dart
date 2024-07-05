import 'package:get_it/get_it.dart';
import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rent_now/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rent_now/features/auth/domain/repository/auth_repository.dart';
import 'package:rent_now/features/auth/domain/usecases/user_login.dart';
import 'package:rent_now/features/auth/domain/usecases/user_register.dart';
import 'package:rent_now/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<BaseService>(() => BaseService())
    //Data Sources
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDatasourceImpl(serviceLocator()))
    //Reporitories
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    //Usecases
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => UserRegister(authRepository: serviceLocator()))
    //Bloc
    ..registerFactory(() =>
        AuthBloc(userLogin: serviceLocator(), userRegister: serviceLocator()));
}
