import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro_admin/core/screen/base_screen.dart';
import 'package:ownsaemiro_admin/presentation/view/qr_screen.dart';
import 'package:ownsaemiro_admin/presentation/view_model/root_view_model.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Color get screenBackgroundColor => const Color(0xFFED7A7A);

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const QRScannerScreen());
              },
              child: const Text(
                "Scan",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
