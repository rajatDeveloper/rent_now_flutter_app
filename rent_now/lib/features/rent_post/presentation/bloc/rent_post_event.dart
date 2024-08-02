part of 'rent_post_bloc.dart';

@immutable
sealed class RentPostEvent {}

final class GetAllRentPostEvent extends RentPostEvent {
  final String category;
  final String pin_code;
  final String token;

  GetAllRentPostEvent(
      {required this.category, required this.pin_code, required this.token});
}

final class GetAllRentPostOfCategoryEvent extends RentPostEvent {
  final String category;
  final String pin_code;
  final String token;

  GetAllRentPostOfCategoryEvent(
      {required this.category, required this.pin_code, required this.token});
}

final class GetMyRentPostEvent extends RentPostEvent {
  final String token;
  final String userId;

  GetMyRentPostEvent({required this.token, required this.userId});
}
