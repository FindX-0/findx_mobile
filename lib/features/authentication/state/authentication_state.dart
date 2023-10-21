import 'dart:developer';

import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../api/auth_status_provider.dart';
import '../api/auth_with_google.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    required SimpleDataState<bool> isSignedIn,
  }) = _AuthenticationState;

  factory AuthenticationState.initial() => AuthenticationState(
        isSignedIn: SimpleDataState.idle(),
      );
}

@injectable
class AuthenticationStateCubit extends Cubit<AuthenticationState> {
  AuthenticationStateCubit(
    this._authStatusProvider,
    this._signInWithGoogle,
  ) : super(AuthenticationState.initial()) {
    _init();
  }

  final AuthStatusProvider _authStatusProvider;
  final AuthWithGoogle _signInWithGoogle;

  Future<void> _init() async {
    emit(state.copyWith(isSignedIn: SimpleDataState.loading()));

    final authStatus = await _authStatusProvider.get();

    emit(state.copyWith(isSignedIn: SimpleDataState.success(authStatus)));
  }

  Future<void> onSignInWithGooglePressed() async {
    final signInResult = await _signInWithGoogle.call();

    final auth = await signInResult?.authentication;

    log(signInResult.toString());
    log('accessToken = ${auth?.accessToken ?? ''}');
    log('idToken = ${auth?.idToken ?? ''}');
  }
}
