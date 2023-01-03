import 'package:flutter/material.dart';
import 'package:sptimer/utils/utils.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({
    Key? key,
    this.child,
    required this.percent,
    required this.radius,
    required this.strokeWidth,
    required this.progressBarColor,
    required this.backgroundColor,
  }) : super(key: key);

  /// should be between zero and one
  final double percent;
  final double radius;
  final double strokeWidth;
  final Color progressBarColor;
  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressBarPainter(
        deg: percent * 360,
        radius: radius,
        strokeWidth: strokeWidth,
        progressBarColor: progressBarColor,
        backgroundColor: backgroundColor,
      ),
      child: SizedBox.fromSize(
        size: Size.fromRadius(radius),
        child: child,
      ),
    );
  }
}

class _CircularProgressBarPainter extends CustomPainter {
  _CircularProgressBarPainter({
    required this.deg,
    required this.radius,
    required this.strokeWidth,
    required this.progressBarColor,
    required this.backgroundColor,
  });

  final double deg;
  final double radius;
  final double strokeWidth;
  final Color progressBarColor;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.centerOffset;
    final progressBarPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = progressBarColor;

    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = backgroundColor;

    if (deg == 360) {
      canvas.drawCircle(center, radius, progressBarPaint);
      return;
    }

    final Path progressBarPath = Path()
      ..arcTo(
        size.centerRect,
        -90.toRad,
        deg.toRad,
        false,
      );

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawPath(progressBarPath, progressBarPaint);
  }

  @override
  bool shouldRepaint(covariant _CircularProgressBarPainter oldDelegate) {
    return oldDelegate.deg != deg;
  }
}
