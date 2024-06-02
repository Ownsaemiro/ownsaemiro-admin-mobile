import 'package:flutter/material.dart';
import 'package:ownsaemiro_admin/core/screen/base_screen.dart';
import 'package:ownsaemiro_admin/presentation/view/dialog/matched_dialog.dart';
import 'package:ownsaemiro_admin/presentation/view/dialog/un_matched_dialog.dart';
import 'package:ownsaemiro_admin/presentation/view/qr_screen.dart';
import 'package:ownsaemiro_admin/presentation/view_model/root_view_model.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  void _navigateToQRScanner(BuildContext context) async {
    final bool isClosed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
    );

    if (isClosed) {
      if (viewModel.isMatched.value) {
        viewModel.playSuccessSound();

        showDialog(
          context: context,
          builder: (context) {
            return MatchedDialog(
              onClose: () {
                viewModel.stopSound();
                Navigator.pop(context);
              },
            );
          },
        );
      } else {
        viewModel.playFailedSound();

        showDialog(
          context: context,
          builder: (context) {
            return UnMatchedDialog(
              onClose: () {
                viewModel.stopSound();
                Navigator.pop(context);
              },
            );
          },
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
            onPressed: () {
              _navigateToQRScanner(context);
            },
            child: const Text("Scan QR Code",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
