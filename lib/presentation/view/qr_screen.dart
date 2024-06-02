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
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final Barcode barcode = capture.barcodes.first;
              controller.onQRCodeScanned(barcode.rawValue ?? "").then(
                (value) {
                  if (value) {
                    Navigator.pop(context, true);
                  }
                },
              );
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
