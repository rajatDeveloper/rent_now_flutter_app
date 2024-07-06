part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent({required this.username, required this.password});
}

final class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String password2;
  final String email;

  AuthRegisterEvent(
      {required this.password2,
      required this.username,
      required this.password,
      required this.email});
}

final class AuthLogoutEvent extends AuthEvent {}
