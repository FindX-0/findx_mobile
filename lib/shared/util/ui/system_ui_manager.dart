abstract class SystemUiManager {
  Future<void> showSystemUi();

  Future<void> hideSystemUi();

  Future<void> lockPortraitOrientation();

  Future<void> lockLandscapeOrientation();

  Future<void> disableOrientationLock();
}
