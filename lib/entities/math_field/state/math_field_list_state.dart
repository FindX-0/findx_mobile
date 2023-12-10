import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../pages/matchmaking_page.dart';
import '../../../shared/state/entity_loader_cubit.dart';

typedef MathFieldListState = SimpleDataState<List<GetAllMathFieldsItem>>;

extension MathFieldListCubitX on BuildContext {
  MathFieldListCubit get mathFieldListCubit => read<MathFieldListCubit>();
}

@injectable
final class MathFieldListCubit extends EntityLoaderCubit<List<GetAllMathFieldsItem>> {
  MathFieldListCubit(
    this._mathFieldRemoteRepository,
    this._pageNavigator,
  ) {
    loadEntityAndEmit();
  }

  final MathFieldRemoteRepository _mathFieldRemoteRepository;
  final PageNavigator _pageNavigator;

  @override
  Future<List<GetAllMathFieldsItem>?> loadEntity() async {
    final res = await _mathFieldRemoteRepository.getAll(onlyPublic: true);

    return res.rightOrNull;
  }

  Future<void> onPlayPressed(GetAllMathFieldsItem mathField) async {
    final args = MatchmakingPageArgs(mathFieldId: mathField.id);

    _pageNavigator.toMatchmaking(args);
  }
}
