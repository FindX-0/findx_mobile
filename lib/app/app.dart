import 'package:flutter/material.dart';
import 'package:global_navigator/global_navigator.dart';

import '../shared/values/themes.dart';
import 'i18n/app_locales.dart';
import 'navigation/page_navigator.dart';
import 'navigation/route_factory.dart';
import 'navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math',
      locale: AppLocales.localeKa,
      localizationsDelegates: AppLocales.localizationsDelegates,
      supportedLocales: AppLocales.supportedLocales,
      initialRoute: Routes.root,
      navigatorObservers: [GNObserver()],
      onGenerateRoute: routeFactory,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      navigatorKey: navigatorKey,
    );
  }
}
