import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/utils/utils.dart';

class CircularRotationalLinesPainter extends CustomPainter {
  CircularRotationalLinesPainter({
    required this.rotationalLinesDeg,
    required this.spaceBetweenRotationalLines,
    required this.strokeWidth,
    required this.showRotationalLines,
    required double radius,
    required this.colors,
  }) : radius = radius + (strokeWidth / 2);

  final double spaceBetweenRotationalLines;
  final double strokeWidth;
  final double radius;
  final double rotationalLinesDeg;
  final bool showRotationalLines;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    if (showRotationalLines) {
      final Offset center = size.centerOffset;
      for (int i = 5; i >= 1; i--) {
        _drawCircularRotationalLine(
          canvas: canvas,
          center: center,
          size: size,
          radius: (radius + strokeWidth / 2) + (i * spaceBetweenRotationalLines),
          deg: rotationalLinesDeg + i * 95,
          alpha: i == 1 ? 0xFF : 0xff - i * 30,
        );
      }
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
    final List<Color> newColors = colors.map((Color item) => item.withAlpha(alpha)).toList();

    final Paint paint = Paint()
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
