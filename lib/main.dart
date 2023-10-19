import 'dart:io';

import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import 'app/app.dart';
import 'app/configuration/global_http_overrides.dart';
import 'app/di/register_dependencies.dart';
import 'app/i18n/app_locales.dart';
import 'app/i18n/translations.dart';
import 'app/navigation/page_navigator.dart';
import 'shared/app_environment.dart';
import 'shared/util/ui/system_ui_manager.dart';

/// Started working on 19 Oct 2023
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppEnvironment.load();

  await registerDependencies(Environment.dev);

  await getIt<SystemUiManager>().lockPortraitOrientation();

  StaticI18N.initialize(
    tr: getIt<AppTranslations>(),
    locale: AppLocales.fallbackLocale,
    fallbackLocale: AppLocales.fallbackLocale,
  );

  GlobalNavigator.navigatorKey = navigatorKey;

  VVOConfig.name.minLength = 2;
  VVOConfig.verificationCode.length = 6;
  VVOConfig.simpleContent.maxLength = 4095;

  HttpOverrides.global = GlobalHttpOverrides();

  runApp(App());
}
