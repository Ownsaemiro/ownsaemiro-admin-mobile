import 'package:ownsaemiro_admin/data/provider/base/base_connect.dart';

abstract class TicketProvider {
  /// 티켓과 사용자 정보의 일치 여부를 판단
  Future<bool> checkTicket(
      String ticketId, String userId, String deviceId, String ticketHash);
}
