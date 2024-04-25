import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/state/searchable_data_pager_with_last_id_cubit.dart';

typedef SearchFriendsState = DataState<NetworkCallError, DataPage<FilterUsersDataRes>>;

extension SearchFriendsCubitX on BuildContext {
  SearchFriendsCubit get searchFriendsCubit => read<SearchFriendsCubit>();
}

@injectable
final class SearchFriendsCubit
    extends SearchableDataPagerWithLastIdCubit<NetworkCallError, FilterUsersDataRes> {
  SearchFriendsCubit(
    this._userRemoteRepository,
  ) : super(allowEmptyQuery: false);

  final UserRemoteRepository _userRemoteRepository;

  @override
  String idSelector(FilterUsersDataRes item) => item.id;

  @override
  Future<Either<NetworkCallError, DataPage<FilterUsersDataRes>>> searchDataPage(
    String? lastId,
    String searchQuery,
  ) {
    return _userRemoteRepository.filter(
      lastId: lastId,
      limit: 20,
    );
  }

  void onFriendAction() {}
}
