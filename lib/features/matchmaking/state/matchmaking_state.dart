import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../entities/ticket/api/ticket_changed_channel.dart';
import '../../../entities/ticket/model/ticket.dart';
import '../../../entities/ticket/model/ticket_state.dart';
import '../../../pages/match_page.dart';
import '../../../shared/app_environment.dart';
import '../../../shared/logger.dart';
import '../../../shared/ui/toast/toast_notifier.dart';

part 'matchmaking_state.freezed.dart';

@freezed
class MatchmakingState with _$MatchmakingState {
  const factory MatchmakingState({
    required bool isMatchmakingPending,
    required MutationState<ActionFailure, EnqueueTicketRes> enqueueTicketState,
  }) = _MatchmakingState;

  factory MatchmakingState.initial() => MatchmakingState(
        isMatchmakingPending: true,
        enqueueTicketState: MutationState.idle(),
      );
}

extension MatchmakingCubitX on BuildContext {
  MatchmakingCubit get matchmakingCubit => read<MatchmakingCubit>();
}

@injectable
class MatchmakingCubit extends Cubit<MatchmakingState> {
  MatchmakingCubit(
    this._matchmakingRemoteRepository,
    this._toastNotifier,
    this._ticketChangedChannel,
    this._pageNavigator,
  ) : super(MatchmakingState.initial()) {
    _subscriptionComposite.add(
      _ticketChangedChannel.events.listen(_onTicketChanged),
    );
    _ticketChangedChannel.startListening();
  }

  final MatchmakingRemoteRepository _matchmakingRemoteRepository;
  final ToastNotifier _toastNotifier;
  final TicketChangedChannel _ticketChangedChannel;
  final PageNavigator _pageNavigator;

  final _subscriptionComposite = SubscriptionComposite();

  String? _mathFieldId;
  Timer? _enqueueTicketTimer;

  Future<void> init({
    required String mathFieldId,
  }) async {
    _mathFieldId = mathFieldId;

    _enqueueTicketTimer = Timer(
      Duration(milliseconds: AppEnvironment.ticketEnqueueDelayMillis),
      () => _enqueueTicket(),
    );
  }

  @override
  Future<void> close() async {
    _enqueueTicketTimer?.cancel();

    await _subscriptionComposite.closeAll();
    await _ticketChangedChannel.dispose();

    return super.close();
  }

  Future<void> onCancelTicketPressed() async {
    if (state.enqueueTicketState.isIdle) {
      _pageNavigator.pop();
      _enqueueTicketTimer?.cancel();
      _enqueueTicketTimer = null;
      return;
    }

    if (state.enqueueTicketState.isExecuting) {
      return;
    }

    final enqueuedTicket = state.enqueueTicketState.dataOrNull;
    if (enqueuedTicket == null || enqueuedTicket.concurrencyTimestamp == null) {
      return;
    }

    final cancelRes = await _matchmakingRemoteRepository.cancelTicket(
      ticketId: enqueuedTicket.id,
      concurrencyTimestamp: enqueuedTicket.concurrencyTimestamp!,
    );

    cancelRes.ifRight((r) => _pageNavigator.pop());
  }

  Future<void> onReEnqueueTicketPressed() async {
    return _enqueueTicket();
  }

  Future<void> _enqueueTicket() async {
    if (_mathFieldId == null) {
      logger.wtf('_mathFieldId is null, returning');
      return;
    }

    emit(state.copyWith(enqueueTicketState: MutationState.executing()));

    final enqueueTicketRes = await _matchmakingRemoteRepository.enqueueTicket(
      mathFieldId: _mathFieldId!,
    );

    emit(state.copyWith(
      enqueueTicketState: MutationState.fromEither(enqueueTicketRes),
    ));
  }

  Future<void> _onTicketChanged(Ticket ticket) async {
    if (ticket.state == null) {
      return;
    }

    if (ticket.state == TicketState.completed && ticket.matchId != null) {
      final args = MatchPageArgs(matchId: ticket.matchId!);

      _pageNavigator.toMatch(args);
      return;
    }

    if (ticket.state == TicketState.cancelled) {
      // TODO handle cancelled ticket
      _toastNotifier.notify(
        message: (l) => l.ticketCancelled,
        title: (l) => l.notification,
      );
      _pageNavigator.pop();
      return;
    }

    if (ticket.state == TicketState.expired) {
      // TODO handle expired ticket
      _toastNotifier.notify(
        message: (l) => l.ticketExpired,
        title: (l) => l.notification,
      );
      _pageNavigator.pop();
      return;
    }
  }
}
