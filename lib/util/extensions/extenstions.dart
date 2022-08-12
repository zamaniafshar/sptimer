import 'dart:math' as math;
import 'package:flutter/material.dart';

extension MathHelpers on num {
  double get toRad => this * (math.pi / 180.0);

  double devideToFraction({
    required num numerator,
    required num denominator,
  }) =>
      this * numerator / denominator;

  int get secToMinutes => this ~/ 60;
  int get secLeft => (this % 60).toInt();
}

extension SizeHelpers on Size {
  Offset get centerOfsset => Offset(width / 2, height / 2);

  Rect get centerRect =>
      Rect.fromCenter(center: centerOfsset, width: width, height: height);

  Shader makeShader(List<Color> colors, double deg) {
    return SweepGradient(
      colors: colors,
      transform: GradientRotation(deg.toRad),
    ).createShader(centerRect);
  }
}

extension ListHelper<E> on List<E> {
  List<E> changeAll(E Function(E item) change) => map(change).toList();
}
