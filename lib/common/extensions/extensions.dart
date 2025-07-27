import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sptimer/config/localization/app_localizations.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';

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

extension ListExtension<T> on List<T> {
  T? findById(int id) {
    final myList = <dynamic>[...this];
    final model = myList.firstWhere((element) => element.id == id, orElse: () => null);
    return model as T?;
  }

  void updateById(dynamic newE) {
    final dynamicList = <dynamic>[...this];
    final index = dynamicList.indexWhere((e) => e.id == newE.id);

    if (index == -1) return;
    this[index] = newE;
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
  ColorScheme get colorScheme => theme.colorScheme;
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

extension ColorX on Color {
  Color withOp(double percent) {
    return withValues(alpha: percent);
  }
}

extension DurationX on Duration {
  String get formatRemainingTime {
    return toString().substring(2, 8);
  }
}
