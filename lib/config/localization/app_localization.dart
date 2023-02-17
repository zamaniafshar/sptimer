import 'package:flutter/material.dart';
import 'package:sptimer/config/localization/app_localization_data.dart';

class AppLocalization extends InheritedWidget {
  const AppLocalization({
    super.key,
    required super.child,
    required this.localization,
    required this.isEnglish,
  });

  final AppLocalizationData localization;
  final bool isEnglish;

  static AppLocalizationData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLocalization>()!.localization;
  }

  static AppLocalization ofParent(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLocalization>()!;
  }

  @override
  bool updateShouldNotify(covariant AppLocalization oldWidget) {
    return localization != oldWidget.localization;
  }
}
