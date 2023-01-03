import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sptimer/utils/utils.dart';

import '../constants.dart';

class ClockLinesPainter extends CustomPainter {
  ClockLinesPainter({
    required this.hide,
    required this.radius,
    required this.colors,
  });

  final bool hide;
  final double radius;
  final List<Color> colors;
  @override
  void paint(Canvas canvas, Size size) {
    if (hide) return;

    final paint = Paint()
      ..shader = size.makeShader(colors, startDeg)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Offset center = size.centerOffset;
    final double line1 = radius;
    final double line2 = radius + 7;

    for (int deg = 0; deg < 360; deg += 30) {
      final double x1 = center.dx + line1 * math.sin(deg.toRad);
      final double y1 = center.dy + line1 * math.cos(deg.toRad);

      final double x2 = center.dx + line2 * math.sin(deg.toRad);
      final double y2 = center.dy + line2 * math.cos(deg.toRad);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ClockLinesPainter oldDelegate) => hide != oldDelegate.hide;
}
