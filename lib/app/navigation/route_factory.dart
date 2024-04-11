import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../pages/dev_page.dart';
import '../../pages/main/main_page.dart';
import '../../pages/match_page.dart';
import '../../pages/match_result_page.dart';
import '../../pages/matchmaking_page.dart';
import '../../pages/math_fields_page.dart';
import 'default_page_route.dart';
import 'routes.dart';

Route<dynamic> routeFactory(RouteSettings settings) {
  return switch (settings.name) {
    Routes.root => _createMainPageRoute(settings),
    Routes.main => _createMainPageRoute(settings),
    Routes.matchmaking => _createMatchmakingPageRoute(settings),
    Routes.match => _createMatchPageRoute(settings),
    Routes.matchResult => _createMatchResultPageRoute(settings),
    Routes.dev => _createDevPageRoute(settings),
    Routes.mathFields => _createMathFieldsPageRoute(settings),
    _ => throw Exception('route ${settings.name} is not supported'),
  };
}

Route _createMathFieldsPageRoute(RouteSettings settings) {
  return DefaultPageRoute(
    builder: (_) => const MathFieldsPage(),
    settings: settings,
  );
}

Route _createMatchResultPageRoute(RouteSettings settings) {
  return DefaultPageRoute(
    settings: settings,
    builder: (_) => MatchResultPage(args: _getArgs(settings)),
  );
}

Route _createDevPageRoute(RouteSettings settings) {
  return DefaultPageRoute(
    settings: settings,
    builder: (_) => const DevPage(),
  );
}

Route _createMatchPageRoute(RouteSettings settings) {
  return DefaultPageRoute(
    settings: settings,
    builder: (_) => MatchPage(
      args: _getArgs<MatchPageArgs>(settings),
    ),
  );
}

Route _createMatchmakingPageRoute(RouteSettings settings) {
  return DefaultPageRoute(
    settings: settings,
    builder: (_) => MatchmakingPage(
      args: _getArgs<MatchmakingPageArgs>(settings),
    ),
  );
}

Route _createMainPageRoute(RouteSettings settings) {
  return DefaultPageRoute<void>(
    settings: settings,
    builder: (_) => const MainPage(),
  );
}

T _getArgs<T>(RouteSettings settings) {
  if (settings.arguments == null || settings.arguments is! T) {
    throw Exception('Arguments typeof ${T.runtimeType} is required');
  }

  return settings.arguments as T;
}
