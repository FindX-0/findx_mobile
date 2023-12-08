import 'package:injectable/injectable.dart';

import '../../../shared/util/enum_mapper.dart';
import '../model/ticket_state.dart';

@lazySingleton
final class TicketStateMapper extends EnumMapper<String, TicketState> {
  @override
  Map<String, TicketState> values = {
    'PROCESSING': TicketState.processing,
    'COMPLETED': TicketState.completed,
    'EXPIRED': TicketState.expired,
    'CANCELLED': TicketState.cancelled,
  };
}
