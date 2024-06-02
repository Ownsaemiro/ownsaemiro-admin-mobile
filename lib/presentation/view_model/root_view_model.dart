import 'package:get/get.dart';

class RootViewModel extends GetxController {
  final RxString scannedData = ''.obs;

  void onQRCodeScanned(String data) {
    scannedData.value = data;
  }
}
