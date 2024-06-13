import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ownsaemiro_admin/presentation/view/painter/qr_scanner_overlay_painter.dart';
import 'package:ownsaemiro_admin/presentation/view_model/root_view_model.dart';

class QRScannerScreen extends GetView<RootViewModel> {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(''),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => controller.isScanningEnabled.value
                ? MobileScanner(
                    onDetect: (capture) async {
                      final Barcode barcode = capture.barcodes.first;

                      controller.isScanningEnabled.value = false;

                      await controller.onQRCodeScanned(barcode.rawValue ?? "");

                      if (controller.isMatched.value) {
                        controller.playSuccessSound();

                        Get.snackbar(
                          "티켓이 확인되었습니다.",
                          "정상적인 사용자입니다.",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      } else {
                        controller.playFailedSound();

                        Get.snackbar(
                          "티켓이 확인되지 않았습니다.",
                          "유효하지 않은 사용자입니다.\n${controller.errorMessage.value}",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }

                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          controller.isScanningEnabled.value = true;
                        },
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Center(
            child: CustomPaint(
              painter: QRScannerOverlayPainter(),
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
