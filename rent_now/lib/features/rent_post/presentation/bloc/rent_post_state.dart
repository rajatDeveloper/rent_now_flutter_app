part of 'rent_post_bloc.dart';

@immutable
sealed class RentPostState {}

final class RentPostInitial extends RentPostState {}

final class GetAllRentPostLoading extends RentPostState {}

final class GetMyRentPostLoading extends RentPostState {}

final class GetAllRentPostSuccess extends RentPostState {
  final List<RentPostModel> rentPosts;

  GetAllRentPostSuccess({required this.rentPosts});
}

final class RentPostFailure extends RentPostState {
  final String message;

  RentPostFailure({required this.message});
}

final class GetAllRentPostCategorySuccess extends RentPostState {
  final List<RentPostModel> rentPosts;

  GetAllRentPostCategorySuccess({required this.rentPosts});
}

final class GetMyRentPostSuccess extends RentPostState {
  final List<RentPostModel> rentPosts;

  GetMyRentPostSuccess({required this.rentPosts});
}
