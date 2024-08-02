import 'package:get_it/get_it.dart';
import 'package:rent_now/base/base_service.dart';
import 'package:rent_now/features/address/data/datasources/address_datasource.dart';
import 'package:rent_now/features/address/data/repositories/address_repo_impl.dart';
import 'package:rent_now/features/address/domain/repository/address_repo.dart';
import 'package:rent_now/features/address/domain/usecases/create_user_address.dart';
import 'package:rent_now/features/address/domain/usecases/get_all_address.dart';
import 'package:rent_now/features/address/presentation/bloc/address_bloc.dart';
import 'package:rent_now/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rent_now/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rent_now/features/auth/domain/repository/auth_repository.dart';
import 'package:rent_now/features/auth/domain/usecases/user_login.dart';
import 'package:rent_now/features/auth/domain/usecases/user_register.dart';
import 'package:rent_now/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rent_now/features/rent_post/data/datasources/rent_post_datasource.dart';
import 'package:rent_now/features/rent_post/data/repositories/rent_post_repo_impl.dart';
import 'package:rent_now/features/rent_post/domain/repository/rent_post_repo.dart';
import 'package:rent_now/features/rent_post/domain/usecases/get_all_categories.dart';
import 'package:rent_now/features/rent_post/domain/usecases/get_all_rent_post.dart';
import 'package:rent_now/features/rent_post/domain/usecases/get_my_rent_post.dart';
import 'package:rent_now/features/rent_post/presentation/bloc/rent_post_bloc.dart';
import 'package:rent_now/features/rent_request/data/datasources/rent_request_type_datasource.dart';
import 'package:rent_now/features/rent_request/data/repositories/rent_request_repo_impl.dart';
import 'package:rent_now/features/rent_request/domain/repository/rent_rerquest_type_repo.dart';
import 'package:rent_now/features/rent_request/domain/usecases/create_rent_request_type.dart';
import 'package:rent_now/features/rent_request/presentation/bloc/rent_request_type_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initRentPost();
  _addressInit();
  _initRentRequestType();
}

void _initRentRequestType() {
  serviceLocator

    //Data Sources
    ..registerFactory<RentRequestTypeDatasource>(
        () => RentRequestTypeDatasourceImpl(serviceLocator()))
    //Reporitories
    ..registerFactory<RentRequestTypeRepo>(
        () => RentRequestRepoImpl(serviceLocator()))
    //Usecases
    ..registerFactory(() => CreateRentRequestType(serviceLocator()))
    //bloc
    ..registerFactory(() => RentRequestTypeBloc(serviceLocator()));
}

void _addressInit() {
  serviceLocator

    //Data Sources
    ..registerFactory<AddressDataSource>(
        () => AddressDataSourceImpl(serviceLocator()))
    //Reporitories
    ..registerFactory<AddressRepo>(() => AddressRepoImpl(serviceLocator()))
    //Usecases
    ..registerFactory(() => GetAllAddress(serviceLocator()))
    ..registerFactory(() => CreateUserAddress(serviceLocator()))
    //bloc
    ..registerFactory(() => AddressBloc(
        getAllAddress: serviceLocator(), createAddress: serviceLocator()));
}

void _initRentPost() {
  serviceLocator
    ..registerFactory<BaseService>(() => BaseService())
    //Data Sources
    ..registerFactory<RentPostDatasource>(
        () => RentPostDatasourceImpl(serviceLocator()))
    //Reporitories
    ..registerFactory<RentPostRepo>(() => RentPostRepoImpl(serviceLocator()))
    //Usecases
    ..registerFactory(() => GetAllCategories(rentPostRepo: serviceLocator()))
    ..registerFactory(() => GetAllRentPost(rentPostRepo: serviceLocator()))
    ..registerFactory(() => GetMyRentPost(rentPostRepo: serviceLocator()))
    //bloc
    ..registerFactory(() => RentPostBloc(
        getMyRentPost: serviceLocator(),
        getAllCategories: serviceLocator(),
        getAllRentPost: serviceLocator()));
}

void _initAuth() {
  serviceLocator
    // ..registerFactory<BaseService>(() => BaseService())
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
