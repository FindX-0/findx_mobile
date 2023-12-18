import 'package:flutter/widgets.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import '../../pages/match_page.dart';
import '../../pages/matchmaking_page.dart';
import 'routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

@lazySingleton
class PageNavigator {
  void pop<T>({T? result}) => GlobalNavigator.maybePop(result: result);

  void toMatchmaking(MatchmakingPageArgs args) {
    GlobalNavigator.pushNamed(Routes.matchmaking, arguments: args);
  }

  void toMatch(MatchPageArgs args) {
    GlobalNavigator.pushNamed(Routes.match, arguments: args);
  }

  void toDev() {
    GlobalNavigator.pushNamed(Routes.dev);
  }
}
