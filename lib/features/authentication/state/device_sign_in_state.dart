import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/util/device_id_provider.dart';
import '../api/auth_status_provider.dart';
import '../api/before_sign_in.dart';

typedef DeviceSignInState = ActionState<ActionFailure>;

extension DeviceSignInCubitX on BuildContext {
  DeviceSignInCubit get deviceSignInCubit => read<DeviceSignInCubit>();
}

@injectable
class DeviceSignInCubit extends Cubit<DeviceSignInState> {
  DeviceSignInCubit(
    this._authFacade,
    this._authStatusProvider,
    this._deviceIdProvider,
    this._beforeSignIn,
    this._authTokenStore,
  ) : super(DeviceSignInState.idle()) {
    _authenticateDeviceOptional();
  }

  final AuthenticationFacade _authFacade;
  final AuthStatusProvider _authStatusProvider;
  final DeviceIdProvider _deviceIdProvider;
  final BeforeSignIn _beforeSignIn;
  final AuthTokenStore _authTokenStore;

  Future<void> onRetryPressed() async {
    return _authenticateDeviceOptional();
  }

  Future<void> _authenticateDeviceOptional() async {
    final isAuthenticated = await _authStatusProvider.get();

    if (isAuthenticated) {
      emit(ActionState.executed());
      return;
    }

    emit(ActionState.executing());

    final deviceId = await _deviceIdProvider.get();

    final res = await _authFacade.deviceSignIn(deviceId: deviceId);

    await res.ifRight(
      (r) async {
        await _beforeSignIn();

        await _authTokenStore.writeAccessToken(r.accessToken);
        await _authTokenStore.writeRefreshToken(r.refreshToken);
      },
    );

    emit(ActionState.fromEither(res));
  }
}
