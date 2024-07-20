import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';

import 'package:rent_now/features/auth/domain/usecases/user_login.dart';
import 'package:rent_now/features/auth/domain/usecases/user_register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserRegister _userRegister;

  AuthBloc({
    required UserLogin userLogin,
    required UserRegister userRegister,
  })  : _userLogin = userLogin,
        _userRegister = userRegister,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // Nothing to do on this state
    });

    on<AuthLoginEvent>((event, emit) async {
      await _onAuthLogin(event, emit);
    });

    on<AuthRegisterEvent>((event, emit) async {
      await _onAuthRegister(event, emit);
    });
  }
  Future<void> _onAuthRegister(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userRegister(UserRegisterParams(
      username: event.username,
      password: event.password,
      password2: event.password2,
      email: event.email,
    ));
    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onAuthLogin(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(UserLoginParams(
      username: event.username,
      password: event.password,
    ));

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
