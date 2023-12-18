import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../app/navigation/page_navigator.dart';

extension MorePageCubitX on BuildContext {
  MorePageCubit get morePageCubit => read<MorePageCubit>();
}

@injectable
class MorePageCubit extends Cubit<Unit> {
  MorePageCubit(
    this._pageNavigator,
  ) : super(unit);

  final PageNavigator _pageNavigator;

  void onToDevPagePressed() {
    _pageNavigator.toDev();
  }
}
