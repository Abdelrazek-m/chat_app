part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginSuccess extends AuthState {}
class LoginLoading extends AuthState {}
class LoginFailure extends AuthState {
  final String errorMassege;
  LoginFailure({required this.errorMassege});
}

class RegisterSuccess extends AuthState {}
class RegisterLoading extends AuthState {}
class RegisterFailure extends AuthState {
  final String errorMassege;

  RegisterFailure({required this.errorMassege});
}
