import 'package:flutter/material.dart';
import 'package:pomotimer/ui/widgets/countdown_timer/constants.dart';
import 'package:pomotimer/util/util.dart';

class CircularLinePainter extends CustomPainter {
  CircularLinePainter({
    required this.strokeWidth,
    required this.currentDeg,
    required double radius,
  }) : radius = radius + (strokeWidth / 2);

  final double currentDeg;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.centerOfsset;
    final Paint roundedLinePanit = Paint()
      ..shader = size.makeShader(kCircularLineShaderColors, startDeg)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (currentDeg == 360) {
      canvas.drawCircle(center, radius, roundedLinePanit);
      return;
    }

    final Path roundedLinePath = Path()
      ..arcTo(
        size.centerRect,
        startDeg.toRad,
        currentDeg.toRad,
        false,
      );

    canvas.drawPath(roundedLinePath, roundedLinePanit);
  }

  @override
  bool shouldRepaint(covariant CircularLinePainter oldDelegate) =>
      oldDelegate.currentDeg != currentDeg;
}
