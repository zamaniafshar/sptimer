import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/theme/system_overlay_theme.dart';
import 'package:pomotimer/theme/themes.dart';

class ThemeManager {
  ThemeMode _mode = ThemeMode.light;

  ThemeData get theme {
    if (_mode == ThemeMode.dark) {
      setSystemOverlayDarkTheme();
      return darkTheme;
    } else {
      setSystemOverlayLightTheme();
      return lightTheme;
    }
  }

  ThemeMode get themeMode => _mode;

  set themeMode(ThemeMode mode) {
    _mode = mode;
    Get.changeTheme(theme);
  }
}
