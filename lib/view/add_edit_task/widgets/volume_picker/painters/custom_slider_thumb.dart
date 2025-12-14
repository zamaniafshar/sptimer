import 'package:flutter/material.dart';

class CustomSliderThumb extends SliderComponentShape {
  CustomSliderThumb({
    required this.thumbRadius,
    required this.primaryColor,
    required this.thumbColor,
  });

  final double thumbRadius;
  final Color primaryColor;
  final Color thumbColor;
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint bigThumbPaint = Paint()..color = Colors.white;
    final Paint littleThumbPaint = Paint()..color = const Color(0xFF50cad1);
    final Path circlePath = Path()..addOval(Rect.fromCircle(center: center, radius: thumbRadius));

    canvas.drawShadow(circlePath, Colors.black.withAlpha(50), 1, true);
    canvas.drawCircle(center, thumbRadius, bigThumbPaint);
    canvas.drawCircle(center, 3, littleThumbPaint);
  }
}
