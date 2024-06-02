import 'package:get/get.dart';
import 'package:ownsaemiro_admin/data/provider/base/base_connect.dart';
import 'package:ownsaemiro_admin/data/provider/ticket/ticket_provider.dart';

class TicketProviderImpl extends BaseConnect implements TicketProvider {
  @override
  Future<Map<String, dynamic>> checkTicket(String ticketId, String userId,
      String deviceId, String ticketHash) async {
    final Response response;

    try {
      response = await post("/api/tickets", {
        "event_id": ticketId,
        "user_id": userId,
        "device_id": deviceId,
        "ticket_hash": ticketHash,
      });
    } catch (e) {
      rethrow;
    }

    return response.body["success"];
  }
}
