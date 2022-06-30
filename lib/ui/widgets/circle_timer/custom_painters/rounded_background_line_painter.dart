import 'package:flutter/material.dart';
import 'package:pomotimer/util/util.dart';

class RoundedBackgroundLinePainter extends CustomPainter {
  RoundedBackgroundLinePainter({
    required this.strokeWidth,
    required double radius,
  }) : radius = radius + (strokeWidth / 2);

  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.centerOfsset;
    final Paint roundedBackgroundLinePaint = Paint()
      ..color = const Color(0xFFD1E6EB)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, roundedBackgroundLinePaint);

    final Paint blurPaint = Paint()
      ..color = const Color(0xFFA4CAD3)
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
