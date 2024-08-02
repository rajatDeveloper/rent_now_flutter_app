part of 'rent_request_type_bloc.dart';

@immutable
sealed class RentRequestTypeEvent {}

// class RentRequestTypeFakeEvent extends RentRequestTypeEvent {}

class RentRequestTypeCreateEvent extends RentRequestTypeEvent {
  final String token;
  final String rentRequestType;
  final double pricePerDuration;

  RentRequestTypeCreateEvent({
    required this.token,
    required this.rentRequestType,
    required this.pricePerDuration,
  });
}
