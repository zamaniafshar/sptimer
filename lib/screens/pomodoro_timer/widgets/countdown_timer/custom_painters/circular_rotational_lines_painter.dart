import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/utils/extensions/extensions.dart';

final class CircularRotationalLinesPainter extends CustomPainter {
  CircularRotationalLinesPainter({
    required this.rotationalLinesDeg,
    required this.spaceBetweenRotationalLines,
    required this.showRotationalLines,
    required this.colors,
    required super.repaint,
  });

  final double spaceBetweenRotationalLines;
  final double rotationalLinesDeg;
  final bool showRotationalLines;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    if (!showRotationalLines) return;

    final center = size.centerOffset;
    final radius = (size.width / 2);

    for (int i = 5; i >= 1; i--) {
      _drawCircularRotationalLine(
        canvas: canvas,
        center: center,
        size: size,
        radius: radius + (i * spaceBetweenRotationalLines),
        deg: rotationalLinesDeg + i * 95,
        alpha: i == 1 ? 0xFF : 0xff - i * 30,
      );
    }
  }

  void _drawCircularRotationalLine({
    required Canvas canvas,
    required Offset center,
    required Size size,
    required double radius,
    required double deg,
    required int alpha,
  }) {
    final newColors = colors.map((Color item) => item.withAlpha(alpha)).toList();

    final paint = Paint()
      ..shader = size.makeShader(newColors, deg)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.r;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CircularRotationalLinesPainter oldDelegate) {
    return rotationalLinesDeg != oldDelegate.rotationalLinesDeg;
  }
}
