import 'package:findx_dart_client/app_client.dart';

import '../model/ticket.dart';

abstract class TicketChangedChannel extends SocketChannel<Ticket> {
  TicketChangedChannel(super.socketInstanceProvider);
}
