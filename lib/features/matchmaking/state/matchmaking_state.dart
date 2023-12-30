import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../entities/ticket/api/ticket_changed_channel.dart';
import '../../../entities/ticket/model/ticket.dart';
import '../../../entities/ticket/model/ticket_state.dart';
import '../../../pages/match_page.dart';
import '../../../shared/logger.dart';
import '../../../shared/ui/toast/toast_notifier.dart';

part 'matchmaking_state.freezed.dart';

@freezed
class MatchmakingState with _$MatchmakingState {
  const factory MatchmakingState({
    required bool isMatchmakingPending,
    required ActionState<SimpleActionFailure> enqueueTicketState,
  }) = _MatchmakingState;

  factory MatchmakingState.initial() => MatchmakingState(
        isMatchmakingPending: true,
        enqueueTicketState: ActionState.idle(),
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

  Future<void> init({
    required String mathFieldId,
  }) async {
    _mathFieldId = mathFieldId;

    await _enqueueTicket();
  }

  @override
  Future<void> close() async {
    await _subscriptionComposite.closeAll();
    await _ticketChangedChannel.dispose();

    return super.close();
  }

  Future<void> onCancelTicketPressed() async {
    _toastNotifier.notify(
      message: (l) => l.notImplemented,
      title: (l) => l.notification,
    );
  }

  Future<void> onReEnqueueTicketPressed() async {
    return _enqueueTicket();
  }

  Future<void> _enqueueTicket() async {
    if (_mathFieldId == null) {
      logger.wtf('_mathFieldId is null, returning');
      return;
    }

    emit(state.copyWith(enqueueTicketState: ActionState.executing()));

    final enqueueTicketRes = await _matchmakingRemoteRepository.enqueueTicket(
      mathFieldId: _mathFieldId!,
    );

    emit(state.copyWith(
      enqueueTicketState: ActionState.fromEither(enqueueTicketRes),
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
