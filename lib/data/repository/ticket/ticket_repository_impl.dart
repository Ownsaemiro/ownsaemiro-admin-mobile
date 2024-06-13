import 'package:get/get.dart';
import 'package:ownsaemiro_admin/app/utility/log_util.dart';
import 'package:ownsaemiro_admin/data/provider/ticket/ticket_provider.dart';
import 'package:ownsaemiro_admin/data/repository/ticket/ticket_repository.dart';

class TicketRepositoryImpl extends GetxService implements TicketRepository {
  late final TicketProvider _ticketProvider;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _ticketProvider = Get.find<TicketProvider>();
  }

  @override
  Future<Map<String, dynamic>> checkTicket(String ticketId, String userId,
      String deviceId, String ticketHash) async {
    Map<String, dynamic> result;

    try {
      result = await _ticketProvider.checkTicket(
          ticketId, userId, deviceId, ticketHash);
    } catch (e) {
      rethrow;
    }

    if (result["success"] == true) {
      return {"success": true};
    } else {
      Map<String, dynamic> error = result["error"];
      return {"success": false, "message": error["message"]};
    }
  }
}
