import 'package:injectable/injectable.dart';

import '../../../shared/util/mappers.dart';
import '../../../shared/values/constants.dart';
import '../model/ticket.dart';
import '../model/ticket_dto.dart';
import 'ticket_state_mapper.dart';

@lazySingleton
class TicketMapper {
  TicketMapper(
    this._ticketStateMapper,
  );

  final TicketStateMapper _ticketStateMapper;

  Ticket dtoToModel(TicketDto dto) {
    return Ticket(
      id: dto.id ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      mathFieldId: dto.mathFieldId ?? kInvalidId,
      userId: dto.userId ?? kInvalidId,
      state: _ticketStateMapper.dtoToEnum(dto.state),
      matchId: dto.matchId,
    );
  }
}
