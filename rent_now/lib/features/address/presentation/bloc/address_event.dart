part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class GetAllAddressEvent extends AddressEvent {
  final String userId;
  final String token;

  GetAllAddressEvent({required this.userId, required this.token});
}

class CreateAddressEvent extends AddressEvent {
  final AddressModel inputAddress;
  final String token;

  CreateAddressEvent({required this.inputAddress, required this.token});
}
