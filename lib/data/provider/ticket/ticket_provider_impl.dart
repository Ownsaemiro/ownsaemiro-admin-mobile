import 'package:get/get.dart';
import 'package:ownsaemiro_admin/app/utility/log_util.dart';
import 'package:ownsaemiro_admin/data/provider/base/base_connect.dart';
import 'package:ownsaemiro_admin/data/provider/ticket/ticket_provider.dart';

class TicketProviderImpl extends BaseConnect implements TicketProvider {
  @override
  Future<bool> checkTicket(String ticketId, String userId, String deviceId,
      String ticketHash) async {
    final Response response;

    try {
      response = await post("/api/admin/check-ticket", {
        "ticket_id": ticketId,
        "user_id": userId,
        "device_id": deviceId,
        "event_hash": ticketHash,
      });
    } catch (e) {
      rethrow;
    }

    LogUtil.info(response.toString());

    return response.body["success"];
  }
}
