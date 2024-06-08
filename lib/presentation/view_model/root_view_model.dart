import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro_admin/app/utility/log_util.dart';
import 'package:ownsaemiro_admin/data/model/ticket_state.dart';
import 'package:ownsaemiro_admin/data/repository/ticket/ticket_repository.dart';

class RootViewModel extends GetxController {
  late final TicketRepository _repository;
  late final AssetsAudioPlayer _passPlayer;
  late final AssetsAudioPlayer _nonPassPlayer;

  final RxString scannedData = ''.obs;
  final RxBool isMatched = false.obs;
  final RxBool isDone = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _repository = Get.find<TicketRepository>();
    _passPlayer = AssetsAudioPlayer.newPlayer();
    _nonPassPlayer = AssetsAudioPlayer.newPlayer();

    _passPlayer.open(Audio("assets/audios/pass.wav"),
        loopMode: LoopMode.none, autoStart: false, showNotification: false);

    _nonPassPlayer.open(Audio("assets/audios/non_pass.wav"),
        loopMode: LoopMode.none, autoStart: false, showNotification: false);
  }

  void playSuccessSound() {
    _passPlayer.play();
  }

  void playFailedSound() {
    _nonPassPlayer.play();
  }

  void stopSound() {
    _passPlayer.stop();
    _nonPassPlayer.stop();
  }

  Future<bool> onQRCodeScanned(String data) async {
    scannedData.value = data;

    try {
      final TicketState ticketState = TicketState.fromString(data);
      final result = await _repository.checkTicket(
        ticketState.eventId,
        ticketState.userId,
        ticketState.deviceId,
        ticketState.ticketHash,
      );

      if (result == true) {
        isMatched.value = true;
        isDone.value = true;
        LogUtil.info("Ticket matched: ${ticketState.eventId}");
        return true; // 스캔 성공 시 true 반환
      } else {
        isMatched.value = false;
        isDone.value = true;
        LogUtil.info("Ticket not matched: ${ticketState.eventId}");
        return true; // 스캔 실패 시 true 반환
      }
    } catch (e) {
      LogUtil.error(e.toString());
      isMatched.value = false;
      isDone.value = false;
      return false; // 예외 발생 시 false 반환
    }
  }
}
