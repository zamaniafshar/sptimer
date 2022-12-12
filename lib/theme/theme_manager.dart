import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/theme/themes.dart';

class ThemeManager extends GetxController {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  /// note: it will create theme data class,
  /// don't use this to get current theme of app
  /// use Theme.of(context) instead.
  ThemeData get getTheme => isLightTheme ? lightTheme : darkTheme;

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    update();
  }
}
