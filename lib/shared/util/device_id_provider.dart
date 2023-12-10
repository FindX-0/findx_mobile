import 'package:flutter_udid/flutter_udid.dart';
import 'package:injectable/injectable.dart';

abstract interface class DeviceIdProvider {
  Future<String> get();
}

@LazySingleton(as: DeviceIdProvider)
class DefaultDeviceIdProvider implements DeviceIdProvider {
  @override
  Future<String> get() {
    return FlutterUdid.consistentUdid;
  }
}
