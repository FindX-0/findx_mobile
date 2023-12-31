import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../pages/match_page.dart';

extension DevPageCubitX on BuildContext {
  DevPageCubit get devPageCubit => read<DevPageCubit>();
}

@injectable
class DevPageCubit extends Cubit<Unit> {
  DevPageCubit(
    this._pageNavigator,
  ) : super(unit);

  final PageNavigator _pageNavigator;

  void onToMatchPagePressed() {
    final args = MatchPageArgs(matchId: '1');

    _pageNavigator.toMatch(args);
  }
}
