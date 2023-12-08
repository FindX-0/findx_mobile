import 'package:freezed_annotation/freezed_annotation.dart';

import 'ticket_state.dart';

part 'ticket.freezed.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required DateTime? createdAt,
    required String mathFieldId,
    required String userId,
    required TicketState? state,
    required String? matchId,
  }) = _Ticket;
}
