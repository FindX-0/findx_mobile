import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum BuildFlavor {
  development,
  production;

  static BuildFlavor fromString(String value) {
    switch (value) {
      case 'development':
        return BuildFlavor.development;
      case 'production':
        return BuildFlavor.production;
      default:
        exit(1);
    }
  }
}

class AppEnvironment {
  AppEnvironment._();

  static Future<void> load() async {
    const environment = kDebugMode ? 'development' : 'production';

    const envFileName = '.env.$environment';

    log('Loading environment: $envFileName');

    final localEnv = await _DotEnvLoader.load('.env.local');

    if (localEnv.isNotEmpty) {
      log('Merging env with local $localEnv');
    }

    await dotenv.load(fileName: envFileName, mergeWith: localEnv);

    log('loaded env ${dotenv.env}');
  }

  static String get apiUrl => dotenv.get('API_URL');

  static String get hubScheme => dotenv.get('HUB_SCHEME');

  static int get hubPort => int.parse(dotenv.get('HUB_PORT'));

  static String get hubHost => dotenv.get('HUB_HOST');

  static String get hubPath => dotenv.get('HUB_PATH');

  static String get supportEmail => dotenv.get('SUPPORT_EMAIL');

  static int get cacheTimeoutInMillis => int.parse(dotenv.get('CACHE_TIMEOUT_IN_MILLIS'));

  static String get featureElucidations => dotenv.get('FEATURE_ELUCIDATIONS');

  static String get featurePremiumPackage => dotenv.get('FEATURE_PREMIUM_PACKAGE');

  static String get featureAudioChapters => dotenv.get('FEATURE_AUDIO_CHAPTERS');

  static String get featureNotes => dotenv.get('FEATURE_NOTES');

  static String get featureChapterSearch => dotenv.get('FEATURE_CHAPTER_SEARCH');
}

class _DotEnvLoader {
  static Future<Map<String, String>> load(String filename) async {
    String? envString;

    try {
      envString = await rootBundle.loadString(filename);
    } catch (e) {
      log('', error: e);
    }

    if (envString == null || envString.isEmpty) {
      return {};
    }

    final fileLines = envString.split('\n');
    const dotEnvParser = Parser();

    return dotEnvParser.parse(fileLines);
  }
}
