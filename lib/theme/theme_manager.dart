import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/theme/themes.dart';

class ThemeManager {
  ThemeMode _mode = ThemeMode.light;

  ThemeData get theme => _mode == ThemeMode.dark ? darkTheme : lightTheme;

  ThemeMode get themeMode => _mode;

  set themeMode(ThemeMode mode) {
    _mode = mode;
    Get.changeTheme(theme);
  }
}
