import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../model/login_request.dart';
import '../../../../model/login_response.dart';
import '../../../../source_n_repository/authentication/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<LoginUserEvent>((event, emit) => doLogin(event, emit));
  }

  doLogin(LoginUserEvent event, emit) async {
    emit(LoginStateBusy(true));
    final result = await _authenticationRepository.loginUser(
        requestData: event.loginRequest);
    result.when(success: (LoginResponse loginResponse) {
      emit(LoginStateBusy(true));
      emit(LoginStateSuccess(loginResponse));
    }, failure: (failure) {
      emit(LoginStateBusy(true));
      emit(LoginStateFailure(failure.toString()));
    });
  }
}
