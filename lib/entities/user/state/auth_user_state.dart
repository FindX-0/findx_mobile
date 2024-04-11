import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/state/entity_loader_cubit.dart';

typedef AuthUserState = SimpleDataState<User>;

@injectable
final class AuthUserCubit extends EntityLoaderCubit<User> {
  AuthUserCubit(
    this._userRemoteRepository,
  ) {
    loadEntityAndEmit();
  }

  final UserRemoteRepository _userRemoteRepository;
  @override
  Future<User?> loadEntity() async {
    final user = await _userRemoteRepository.getAuthUser();

    return user.rightOrNull;
  }
}
