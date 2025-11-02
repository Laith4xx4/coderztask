import 'package:flutter/foundation.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

@immutable
class AuthInitial extends AuthState {
  const AuthInitial();
}

@immutable
class AuthLoading extends AuthState {
  const AuthLoading();
}

@immutable
class AuthSuccess extends AuthState {
  final String token;
  final String role;

  const AuthSuccess({required this.token, required this.role});
}

@immutable
class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});
}

@immutable
class AuthRegistrationSuccess extends AuthState {
  final String message;
  final String role;

  const AuthRegistrationSuccess({required this.message, required this.role});
}
