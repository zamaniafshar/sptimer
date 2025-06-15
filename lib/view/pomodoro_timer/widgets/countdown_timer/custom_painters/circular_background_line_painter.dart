import 'package:flutter/material.dart';
import 'package:sptimer/common/extensions/extensions.dart';

final class CircularBackgroundLinePainter extends CustomPainter {
  CircularBackgroundLinePainter({
    required this.strokeWidth,
    required this.backgroundColor,
    required this.shadowColor,
  });

  final double strokeWidth;
  final Color backgroundColor;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.centerOffset;
    final radius = size.width / 2;
    final roundedBackgroundLinePaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, roundedBackgroundLinePaint);

    final blurPaint = Paint()
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
