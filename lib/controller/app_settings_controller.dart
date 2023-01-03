import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sptimer/data/databases/app_settings_database.dart';
import 'package:sptimer/data/models/app_settings.dart';
import 'package:sptimer/data/models/app_texts.dart';
import 'package:sptimer/localization/localizations.dart';
import 'package:sptimer/theme/themes.dart';

class AppSettingsController extends GetxController {
  final _settingsDatabase = AppSettingsDatabase();
  late ThemeData _theme;
  late bool _isDarkTheme;
  late AppTexts _appTexts;
  late StreamController _localeNotifier;
  AppSettings? _appSettings;

  ThemeData get theme => _theme;
  bool get isDarkTheme => _isDarkTheme;
  bool get isEnglish => _appTexts.locale == englishLocale;
  AppTexts get appTexts => _appTexts;

  Future<void> init() async {
    _localeNotifier = StreamController.broadcast();
    await _settingsDatabase.init();
    final settings = await _settingsDatabase.getSettings();
    settings.fold(
      (l) => log(l.toString()),
      (r) {
        _appSettings = r;
        if (_appSettings != null) {
          _initLocale(_appSettings!.isEnglish);
        } else {
          final isEnglishLocale = Platform.localeName.substring(0, 2) == 'en';
          _initLocale(isEnglishLocale);
        }
      },
    );
  }

  void initializeTheme() {
    if (_appSettings != null) {
      _initTheme(_appSettings!.isDarkTheme);
    } else {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      _initTheme(brightness == Brightness.dark);
      _saveSettings();
    }
  }

  void listenToLocaleChange(void Function(bool isEnglish) listener) {
    _localeNotifier.stream.listen((_) {
      listener(isEnglish);
    });
  }

  Future<void> _saveSettings() async {
    await _settingsDatabase.saveSettings(
      AppSettings(isDarkTheme: isDarkTheme, isEnglish: isEnglish),
    );
  }

  void toggleLocalization() {
    _initLocale(!isEnglish);
    _initTheme(_isDarkTheme);
    update();
    _localeNotifier.add(null);
    _saveSettings();
  }

  void toggleTheme() {
    _initTheme(!_isDarkTheme);
    update();
    _saveSettings();
  }

  void _initTheme(bool isDark) {
    _isDarkTheme = isDark;
    _theme = isDark ? darkTheme(appTexts.fontFamily) : lightTheme(appTexts.fontFamily);
  }

  void _initLocale(bool isEnglishLocale) {
    _appTexts = isEnglishLocale ? englishLocalization : persianLocalization;
  }
}
