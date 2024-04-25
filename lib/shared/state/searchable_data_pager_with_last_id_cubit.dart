import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:meta/meta.dart';

import 'data_pager_with_last_id_cubit.dart';

abstract base class SearchableDataPagerWithLastIdCubit<F extends Object?, T extends Object?>
    extends DataPagerWithLastIdCubit<F, T> {
  SearchableDataPagerWithLastIdCubit({
    required this.allowEmptyQuery,
  });

  final bool allowEmptyQuery;

  Timer? _debounce;
  String _searchQuery = '';

  @mustCallSuper
  @override
  Future<void> close() async {
    _debounce?.cancel();

    return super.close();
  }

  @nonVirtual
  Future<void> onSearchQueryChanged(String value) async {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (_searchQuery == value) {
          return;
        }

        _searchQuery = value;

        if (!allowEmptyQuery && _searchQuery.isEmpty) {
          emit(DataState<F, DataPage<T>>.success(DataPage<T>.empty()));
          return;
        }

        onRefresh();
      },
    );
  }

  @nonVirtual
  @override
  Future<Either<F, DataPage<T>>> provideDataPage(String? lastId) async =>
      searchDataPage(lastId, _searchQuery);

  @protected
  Future<Either<F, DataPage<T>>> searchDataPage(String? lastId, String searchQuery);
}
