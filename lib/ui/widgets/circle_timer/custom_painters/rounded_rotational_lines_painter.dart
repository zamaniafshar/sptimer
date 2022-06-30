import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/ui/widgets/circle_timer/constants.dart';
import 'package:pomotimer/util/util.dart';

class RoundedRotationalLinesPainter extends CustomPainter {
  RoundedRotationalLinesPainter({
    required this.rotationalLinesDeg,
    required this.spaceBetweenRotationalLines,
    required this.strokeWidth,
    required this.showRotationalLines,
    required double radius,
  }) : radius = radius + (strokeWidth / 2);

  final double spaceBetweenRotationalLines;
  final double strokeWidth;
  final double radius;
  final double rotationalLinesDeg;
  final bool showRotationalLines;

  @override
  void paint(Canvas canvas, Size size) {
    if (showRotationalLines) {
      final Offset center = size.centerOfsset;
      for (int i = 5; i >= 1; i--) {
        _drawRoundedRotationalLine(
          canvas: canvas,
          center: center,
          size: size,
          radius:
              (radius + strokeWidth / 2) + (i * spaceBetweenRotationalLines),
          deg: rotationalLinesDeg + i * 95,
          alpha: i == 1 ? 0xFF : 0xff - i * 30,
        );
      }
    }
  }

  void _drawRoundedRotationalLine({
    required Canvas canvas,
    required Offset center,
    required Size size,
    required double radius,
    required double deg,
    required int alpha,
  }) {
    final List<Color> colors = kRoundedrotationalLinesShaderColors
        .changeAll((Color item) => item.withAlpha(alpha));

    final Paint paint = Paint()
      ..shader = size.makeShader(colors, deg)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.r;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant RoundedRotationalLinesPainter oldDelegate) {
    return rotationalLinesDeg != oldDelegate.rotationalLinesDeg;
  }
}
