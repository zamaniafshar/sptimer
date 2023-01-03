import 'package:flutter/material.dart';
import 'package:sptimer/data/models/app_texts.dart';

class AppLocalization extends InheritedWidget {
  const AppLocalization({
    super.key,
    required super.child,
    required this.appTexts,
    required this.isEnglish,
  });

  final AppTexts appTexts;
  final bool isEnglish;

  static AppTexts of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLocalization>()!.appTexts;
  }

  static AppLocalization ofParent(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLocalization>()!;
  }

  @override
  bool updateShouldNotify(covariant AppLocalization oldWidget) {
    return appTexts.locale.languageCode != oldWidget.appTexts.locale.languageCode;
  }
}
