import 'package:flutter/material.dart';
import 'package:sptimer/utils/utils.dart';

class ShadowPainter extends CustomPainter {
  ShadowPainter({
    required this.lightShadowColor,
    required this.darkShadowColor,
  });

  final Color lightShadowColor;
  final Color darkShadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.centerOffset;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [lightShadowColor, darkShadowColor],
        center: Alignment.topLeft,
        radius: 1.5,
        stops: const [
          0.5,
          1,
        ],
      ).createShader(
        Rect.fromCenter(
          center: center,
          width: size.width,
          height: size.height,
        ),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(center, size.height, paint);
  }

  @override
  bool shouldRepaint(covariant ShadowPainter oldDelegate) {
    return oldDelegate.lightShadowColor != lightShadowColor ||
        oldDelegate.darkShadowColor != darkShadowColor;
  }
}
