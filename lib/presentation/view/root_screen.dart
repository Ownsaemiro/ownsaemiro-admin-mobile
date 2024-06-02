import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro_admin/core/screen/base_screen.dart';
import 'package:ownsaemiro_admin/presentation/view/qr_screen.dart';
import 'package:ownsaemiro_admin/presentation/view_model/root_view_model.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  void _navigateToQRScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              _navigateToQRScanner(context);
            },
            child: const Text("Scan QR Code"),
          ),
          const SizedBox(height: 20),
          Obx(() {
            final scannedData = viewModel.scannedData.value;
            return Text(
              scannedData.isEmpty
                  ? "No data scanned"
                  : "Scanned data: $scannedData",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            );
          }),
        ],
      ),
    );
  }
}
