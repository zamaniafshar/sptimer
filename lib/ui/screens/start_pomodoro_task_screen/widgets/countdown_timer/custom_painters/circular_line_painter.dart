import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:pomotimer/util/util.dart';

class CircularLinePainter extends CustomPainter {
  CircularLinePainter({
    required this.colors,
    required this.strokeWidth,
    required this.currentDeg,
    required double radius,
  }) : radius = radius + (strokeWidth / 2);

  final double currentDeg;
  final double strokeWidth;
  final double radius; 
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.centerOffset;
    final Paint roundedLinePaint = Paint()
      ..shader = size.makeShader(colors, startDeg)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (currentDeg == 360) {
      canvas.drawCircle(center, radius, roundedLinePaint);
      return;
    }

    final Path roundedLinePath = Path()
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
