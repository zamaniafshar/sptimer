import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension MathHelpers on num {
  double get toRad => this * (math.pi / 180.0);

  double divideToFraction({
    required num numerator,
    required num denominator,
  }) =>
      this * numerator / denominator;

  int get secToMinutes => this ~/ 60;
  int get secLeft => (this % 60).toInt();
  bool isAroundOf(double value, double around) => (this - value).abs() <= around;
}

extension SizeHelpers on Size {
  Offset get centerOffset => Offset(width / 2, height / 2);

  Rect get centerRect => Rect.fromCenter(center: centerOffset, width: width, height: height);

  Shader makeShader(List<Color> colors, double deg) {
    return SweepGradient(
      colors: colors,
      transform: GradientRotation(deg.toRad),
    ).createShader(centerRect);
  }
}

extension LinearGradientMaker on List<Color> {
  LinearGradient get getLinearGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: this,
      );
}

extension DateTimeHelper on DateTime {
  bool isInSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  DateTime get roundToDay => DateTime(year, month, day);

  String get convertToDateString => '$year/$month/$day';
}

extension DateHelper on Date {
  bool isInSameDay(Date other) => year == other.year && month == other.month && day == other.day;

  Date get roundToDay {
    if (this is Jalali) return Jalali(year, month, day);
    return Gregorian(year, month, day);
  }

  String get convertToDateString => '$year/$month/$day';
}
