import 'package:flutter/material.dart';
import 'package:pomotimer/utils/utils.dart';

class CircularBackgroundLinePainter extends CustomPainter {
  CircularBackgroundLinePainter({
    required this.strokeWidth,
    required double radius,
    required this.backgroundColor,
    required this.shadowColor,
  }) : radius = radius + (strokeWidth / 2);

  final double strokeWidth;
  final double radius;
  final Color backgroundColor;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.centerOffset;
    final Paint roundedBackgroundLinePaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, roundedBackgroundLinePaint);

    final Paint blurPaint = Paint()
      ..color = shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..strokeWidth = strokeWidth / 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - (strokeWidth / 2), blurPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
