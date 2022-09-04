import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/theme/system_overlay_theme.dart';
import 'package:pomotimer/theme/themes.dart';

class ThemeManager {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  ThemeData get theme {
    if (isLightTheme) {
      setSystemOverlayLightTheme();
      return lightTheme;
    } else {
      setSystemOverlayDarkTheme();
      return darkTheme;
    }
  }

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    Get.changeTheme(theme);
  }
}
