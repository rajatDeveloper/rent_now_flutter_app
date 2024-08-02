part of 'rent_request_type_bloc.dart';

@immutable
sealed class RentRequestTypeState {}

final class RentRequestTypeInitial extends RentRequestTypeState {}

final class RentRequestTypeLoading extends RentRequestTypeState {}

final class RentRequestTypeError extends RentRequestTypeState {
  final String message;

  RentRequestTypeError(this.message);
}

final class RentRequestTypeLoaded extends RentRequestTypeState {
  final RentRequestModel rentRequestModel;

  RentRequestTypeLoaded(this.rentRequestModel);
}
