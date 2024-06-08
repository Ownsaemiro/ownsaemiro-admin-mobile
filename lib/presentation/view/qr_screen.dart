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
            Get.back(result: false); // 스캔 취소 시 false 반환
          },
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) async {
              final Barcode barcode = capture.barcodes.first;
              final result =
                  await controller.onQRCodeScanned(barcode.rawValue ?? "");
              Get.back(result: result); // 스캔 결과에 따라 true 또는 false 반환
            },
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
