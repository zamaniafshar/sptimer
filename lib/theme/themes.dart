import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/theme/text_themes.dart';

ThemeData get lightTheme {
  final textTheme = lightTextTheme;
  return ThemeData(
    backgroundColor: AppColors.white,
    primaryColor: AppColors.lightBlue,
    primaryColorDark: AppColors.lightBlue.shade700,
    primaryColorLight: AppColors.lightBlue.shade300,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.light(
      surface: AppColors.white.shade400,
      surfaceVariant: AppColors.white.shade600,
      secondary: AppColors.lightGreen,
      secondaryContainer: AppColors.darkGreen,
      primaryContainer: AppColors.lightBlue.shade600,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      surfaceTintColor: AppColors.lightBlue,
      titleTextStyle: textTheme.headlineSmall,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.lightBlue.shade600,
        onPrimary: Colors.white,
      ),
    ),
    textTheme: textTheme,
    primaryTextTheme: lightPrimaryTextTheme,
  );
}

ThemeData get darkTheme => ThemeData();
