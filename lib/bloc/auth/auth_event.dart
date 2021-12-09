part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnLoginEvent extends AuthEvent {
  final String email;
  final String password;

  OnLoginEvent(this.email, this.password);
}

class OnCheckingLoginEvent extends AuthEvent {}

class OnLogOutEvent extends AuthEvent {}