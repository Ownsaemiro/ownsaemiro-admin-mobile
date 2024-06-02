import 'package:flutter/material.dart';

class QRScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final center = Offset(size.width / 2, size.height / 2);
    const finderSize = 200.0;

    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: center, width: finderSize, height: finderSize),
            const Radius.circular(8),
          ),
        )
        ..close(),
    );

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final borderRect =
        Rect.fromCenter(center: center, width: finderSize, height: finderSize);
    canvas.drawRRect(
      RRect.fromRectAndRadius(borderRect, const Radius.circular(8)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
