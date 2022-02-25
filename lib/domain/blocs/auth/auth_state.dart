part of 'auth_bloc.dart';

@immutable
class AuthState {}

class LoadingAuthentication extends AuthState {}

class SuccessAuthentication extends AuthState {}

class FailureAuthentication extends AuthState {
  final String error;

  FailureAuthentication(this.error);
}

class LogOut extends AuthState {}