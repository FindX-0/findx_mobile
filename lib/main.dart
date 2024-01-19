import 'dart:io';

import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import 'app/app.dart';
import 'app/configuration/global_http_overrides.dart';
import 'app/di/register_dependencies.dart';
import 'app/navigation/page_navigator.dart';
import 'features/server_time/api/get_server_time.dart';
import 'shared/app_environment.dart';
import 'shared/util/ui/system_ui_manager.dart';

/// Started working on 19 Oct 2023
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppEnvironment.load();

  await registerDependencies(Environment.dev);

  await getIt<SystemUiManager>().lockPortraitOrientation();

  GlobalNavigator.navigatorKey = navigatorKey;

  VVOConfig.name.minLength = 2;
  VVOConfig.verificationCode.length = 6;
  VVOConfig.requiredString.maxLength = 4095;

  HttpOverrides.global = GlobalHttpOverrides();

  getIt<GetServerTime>().call(); // precache server time

  runApp(const App());
}
