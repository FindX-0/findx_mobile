import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'system_ui_manager.dart';

@LazySingleton(as: SystemUiManager)
class SystemUiManagerImpl implements SystemUiManager {
  @override
  Future<void> showSystemUi() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: <SystemUiOverlay>[
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
  }

  @override
  Future<void> hideSystemUi() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Future<void> lockPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
  }

  @override
  Future<void> lockLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Future<void> disableOrientationLock() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[]);
  }
}
