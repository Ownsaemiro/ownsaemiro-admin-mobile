import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro_admin/app/utility/log_util.dart';
import 'package:ownsaemiro_admin/data/model/ticket_state.dart';
import 'package:ownsaemiro_admin/data/repository/ticket/ticket_repository.dart';

class RootViewModel extends GetxController {
  late final TicketRepository _repository;
  late final AssetsAudioPlayer _passPlayer;
  late final AssetsAudioPlayer _nonPassPlayer;
  late final TicketState _ticketState;

  final RxString scannedData = ''.obs;
  final RxBool isMatched = false.obs;

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
      _ticketState = TicketState.fromString(data);
      final result = await _repository.checkTicket(
        _ticketState.eventId,
        _ticketState.userId,
        _ticketState.deviceId,
        _ticketState.ticketHash,
      );

      if (result['success'] == true) {
        isMatched.value = true;
        return true;
      } else {
        isMatched.value = false;
        return true;
      }
    } catch (e) {
      LogUtil.error(e.toString());
      isMatched.value = false;
      return true;
    }
  }
}
