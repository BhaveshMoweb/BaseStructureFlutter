part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginStateBusy extends LoginState{
  final bool isBusy;

  LoginStateBusy(this.isBusy);
}

class LoginStateFailure extends LoginState{
  final String error;

  LoginStateFailure(this.error);
}

class LoginStateSuccess extends LoginState{
  final LoginResponse loginResponse;

  LoginStateSuccess(this.loginResponse);
}