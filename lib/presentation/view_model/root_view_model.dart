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
  RxString errorMessage = ''.obs;
  final RxBool isScanningEnabled = true.obs;

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

  Future<void> onQRCodeScanned(String data) async {
    scannedData.value = data;

    try {
      final TicketState ticketState = TicketState.fromString(data);
      final result = await _repository.checkTicket(
        ticketState.eventId,
        ticketState.userId,
        ticketState.deviceId,
        ticketState.ticketHash,
      );

      LogUtil.info(result);

      LogUtil.info(result["success"]);
      LogUtil.info(result["message"]);

      if (result["success"] == true) {
        isMatched.value = true;
      } else {
        isMatched.value = false;

        if (result["message"]) {
          errorMessage.value = result["message"];

          LogUtil.info(errorMessage.value);
        } else {
          errorMessage.value = "서버와 통신 중 오류가 발생했습니다. 다시 시도해주세요.";
        }

        LogUtil.info(errorMessage.value);
      }
    } catch (e) {
      LogUtil.error(e.toString());
      isMatched.value = false;
      errorMessage.value = "서버와 통신 중 오류가 발생했습니다. 다시 시도해주세요.";
    }
  }
}
