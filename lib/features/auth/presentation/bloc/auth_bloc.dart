import 'package:blog/core/cubits/AppUser/app_user_cubit.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/use_cases/getCurrentUser.dart';
import 'package:blog/features/auth/domain/use_cases/user_login.dart';
import 'package:blog/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/User.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final Getcurrentuser _getcurrentuser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserLogin userLogin,
      required UserSignUp userSignUp,
      required Getcurrentuser getcurrentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _getcurrentuser = getcurrentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    );
    on<AuthSignUp>(_AuthSignUp);
    on<AuthSignIn>(_AuthLogin);
    on<AuthGetUser>(_AuthGetUser);
  }
  void _AuthGetUser(AuthGetUser event, Emitter<AuthState> emit) async {
    final res = await _getcurrentuser(NoParms());
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSucess(r, emit));
  }

  void _AuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
        UserSignUpParms(event.name, event.email, event.password));
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSucess(r, emit));
  }

  void _AuthLogin(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
        UserSigninParms(email: event.email, password: event.password));
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSucess(r, emit));
  }

  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
