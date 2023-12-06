import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/state/entity_loader_cubit.dart';

typedef MathFieldListState = SimpleDataState<List<GetAllMathFieldsItem>>;

@injectable
final class MathFieldListCubit extends EntityLoaderCubit<List<GetAllMathFieldsItem>> {
  MathFieldListCubit(
    this._mathFieldRemoteRepository,
  ) {
    loadEntityAndEmit();
  }

  final MathFieldRemoteRepository _mathFieldRemoteRepository;

  @override
  Future<List<GetAllMathFieldsItem>?> loadEntity() async {
    final res = await _mathFieldRemoteRepository.getAll(onlyPublic: true);

    return res.rightOrNull;
  }
}
