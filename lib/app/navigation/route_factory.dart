import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../pages/main/main_page.dart';
import 'default_page_route.dart';
import 'routes.dart';

Route<dynamic> routeFactory(RouteSettings settings) {
  return switch (settings.name) {
    Routes.root => _createMainPageRoute(settings),
    Routes.main => _createMainPageRoute(settings),
    _ => throw Exception('route ${settings.name} is not supported'),
  };
}

Route<dynamic> _createMainPageRoute(RouteSettings settings) {
  return DefaultPageRoute<void>(
    builder: (_) => const MainPage(),
    settings: settings,
  );
}
