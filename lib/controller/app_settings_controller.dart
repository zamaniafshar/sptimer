import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sptimer/data/databases/app_settings_database.dart';
import 'package:sptimer/data/models/app_settings.dart';
import 'package:sptimer/config/localization/app_localization_data.dart';
import 'package:sptimer/config/localization/localizations.dart';
import 'package:sptimer/config/theme/themes.dart';

class AppSettingsController extends GetxController {
  final _settingsDatabase = AppSettingsDatabase();
  late ThemeData _theme;
  late bool _isDarkTheme;
  late AppLocalizationData _appTexts;
  late bool _isFirstAppRun;
  AppSettings? _appSettings;

  ThemeData get theme => _theme;
  bool get isDarkTheme => _isDarkTheme;
  bool get isEnglish => _appTexts.locale == englishLocale;
  bool get isFirstAppRun => _isFirstAppRun;
  AppLocalizationData get localization => _appTexts;

  Future<void> init() async {
    await _settingsDatabase.init();
    final settings = await _settingsDatabase.getSettings();
    settings.fold(
      (l) => log(l.toString()),
      (r) {
        _appSettings = r;
        if (_appSettings != null) {
          _isFirstAppRun = false;
          _initLocale(_appSettings!.isEnglish);
        } else {
          _isFirstAppRun = true;
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

  Future<void> _saveSettings() async {
    await _settingsDatabase.saveSettings(
      AppSettings(isDarkTheme: isDarkTheme, isEnglish: isEnglish),
    );
  }

  void toggleLocalization() {
    _initLocale(!isEnglish);
    _initTheme(_isDarkTheme);
    update();
    _saveSettings();
  }

  void toggleTheme() {
    _initTheme(!_isDarkTheme);
    update();
    _saveSettings();
  }

  void _initTheme(bool isDark) {
    _isDarkTheme = isDark;
    _theme = isDark ? darkTheme(localization.fontFamily) : lightTheme(localization.fontFamily);
  }

  void _initLocale(bool isEnglishLocale) {
    _appTexts = isEnglishLocale ? englishLocalization : persianLocalization;
  }
}
