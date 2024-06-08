abstract class TicketRepository {
  /// 티켓과 사용자 정보의 일치 여부를 판단
  Future<bool> checkTicket(
      String ticketId, String userId, String deviceId, String ticketHash);
}
