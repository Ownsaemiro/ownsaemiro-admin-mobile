import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro_admin/core/screen/base_screen.dart';
import 'package:ownsaemiro_admin/presentation/view/qr_screen.dart';
import 'package:ownsaemiro_admin/presentation/view_model/root_view_model.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  Future<void> _navigateToQRScanner(BuildContext context) async {
    final bool isClosed = await Get.to(() => const QRScannerScreen());

    if (isClosed) {
      if (viewModel.isMatched.value) {
        viewModel.playSuccessSound();
        Get.snackbar(
          "QR 코드와 사용자 정보가 일치합니다.",
          "정상적인 사용자입니다.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        viewModel.playFailedSound();
        Get.snackbar(
          "QR 코드와 사용자 정보가 일치하지 않습니다.",
          "비정상적인 사용자입니다.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () => _navigateToQRScanner(context),
            child: const Text(
              "Scan",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
