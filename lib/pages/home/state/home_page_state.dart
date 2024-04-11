import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';

extension HomePageCubitX on BuildContext {
  HomePageCubit get homePageCubit => read<HomePageCubit>();
}

@injectable
class HomePageCubit extends Cubit<Unit> {
  HomePageCubit(
    this._pageNavigator,
  ) : super(unit);

  final PageNavigator _pageNavigator;

  void onPlayPressed() {
    _pageNavigator.toMathFields();
  }
}
