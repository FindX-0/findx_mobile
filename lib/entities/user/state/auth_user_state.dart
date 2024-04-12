import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/state/entity_loader_cubit.dart';

typedef AuthUserState = SimpleDataState<GetAuthUserRes>;

@injectable
final class AuthUserCubit extends EntityLoaderCubit<GetAuthUserRes> {
  AuthUserCubit(
    this._userRemoteRepository,
  ) {
    loadEntityAndEmit();
  }

  final UserRemoteRepository _userRemoteRepository;

  @override
  Future<GetAuthUserRes?> loadEntity() async {
    final user = await _userRemoteRepository.getAuthUser();

    return user.rightOrNull;
  }
}
