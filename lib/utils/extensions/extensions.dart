import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

extension ListX<E> on List<E> {
  void replaceFirstWhere(
    E replaceValue,
    bool Function(E e) test, {
    void Function()? orElse,
  }) {
    final index = indexWhere(test);
    if (index == -1) {
      if (orElse != null) {
        orElse.call();
      } else {
        throw StateError('element not found');
      }
    }

    this[index] = replaceValue;
  }

  E? firstWhereOrNull(bool Function(E e) test) {
    final index = indexWhere(test);
    if (index == -1) return null;

    return elementAt(index);
  }
}

extension AsExtension on Object? {
  X? asOrNull<X extends Object>() {
    var self = this;
    return self is X ? self : null;
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  AppLocalizations get localization => AppLocalizations.of(this)!;
}

extension NumX on double {
  double mapToPercent(double min, double max) {
    return mapToValue(min, max, 0.0, 1.0);
  }

  double mapFromPercent(double min, double max) {
    return mapToValue(0.0, 1.0, min, max);
  }

  double mapToValue(double minInput, double maxInput, double minOutput, double maxOutput) {
    final value = this;

    final clampedValue = value.clamp(minInput, maxInput);
    final ratio = (clampedValue - minInput) / (maxInput - minInput);

    final mappedValue = minOutput + (maxOutput - minOutput) * ratio;

    return mappedValue;
  }
}
