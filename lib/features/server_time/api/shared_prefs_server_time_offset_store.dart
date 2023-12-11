import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'server_time_offset_store.dart';

const _kPositiveDiffKey = 'server_time_positive_diff';

@LazySingleton(as: ServerTimeOffsetStore)
class SharedPrefsServerTimeOffsetStore implements ServerTimeOffsetStore {
  SharedPrefsServerTimeOffsetStore(
    this._sharedPreferences,
  );

  final SharedPreferences _sharedPreferences;

  @override
  Future<int?> read() {
    final value = _sharedPreferences.getInt(_kPositiveDiffKey);

    return Future.value(value);
  }

  @override
  Future<void> write(int value) {
    _sharedPreferences.setInt(_kPositiveDiffKey, value);

    return Future.value();
  }
}
