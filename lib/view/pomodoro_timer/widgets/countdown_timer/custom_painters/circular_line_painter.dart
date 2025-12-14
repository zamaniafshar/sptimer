import 'package:flutter/material.dart';
import 'package:sptimer/view/pomodoro_timer/widgets/countdown_timer/constants.dart';
import 'package:sptimer/common/extensions/extensions.dart';

final class CircularLinePainter extends CustomPainter {
  CircularLinePainter({
    required this.colors,
    required this.strokeWidth,
    required this.currentDeg,
  });

  final double currentDeg;
  final double strokeWidth;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.centerOffset;
    final radius = size.width / 2;
    final roundedLinePaint = Paint()
      ..shader = size.makeShader(colors, startDeg)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (currentDeg == 360) {
      canvas.drawCircle(center, radius, roundedLinePaint);
      return;
    }

    final roundedLinePath = Path()
      ..arcTo(
        size.centerRect,
        startDeg.toRad,
        currentDeg.toRad,
        false,
      );

    canvas.drawPath(roundedLinePath, roundedLinePaint);
  }

  @override
  bool shouldRepaint(covariant CircularLinePainter oldDelegate) =>
      oldDelegate.currentDeg != currentDeg;
}
