import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../shared/network/gateway_event.dart';
import '../model/ticket.dart';
import '../model/ticket_dto.dart';
import '../util/ticket_mapper.dart';
import 'ticket_changed_channel.dart';

@Injectable(as: TicketChangedChannel)
class TicketChangedChannelImpl extends TicketChangedChannel {
  TicketChangedChannelImpl(
    super.socketInstanceProvider,
    this._ticketMapper,
  );

  final TicketMapper _ticketMapper;

  @override
  String get event => GatewayEvent.ticketChanged;

  @override
  FutureOr<Ticket> map(dynamic event) {
    return _ticketMapper.dtoToModel(
      TicketDto.fromJson(event as Map<String, dynamic>),
    );
  }
}
