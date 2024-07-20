part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressLoaded extends AddressState {
  final List<AddressModel> addressList;

  AddressLoaded({required this.addressList});
}

final class AddressError extends AddressState {
  final String message;

  AddressError({required this.message});
}

final class AddressCreated extends AddressState {
  final AddressModel addressModel;

  AddressCreated({required this.addressModel});
}
