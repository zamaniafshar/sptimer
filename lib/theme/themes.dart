import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/theme/text_themes.dart';

ThemeData lightTheme(String fontFamily) {
  final textTheme = lightTextTheme;
  return ThemeData(
    dialogBackgroundColor: Colors.red,
    backgroundColor: AppColors.white,
    fontFamily: fontFamily,
    primaryColor: AppColors.lightBlue,
    primaryColorDark: AppColors.lightBlue.shade700,
    primaryColorLight: AppColors.lightBlue.shade300,
    cardColor: AppColors.lightBlue.shade200,
    scaffoldBackgroundColor: AppColors.white,
    // dark shadow color
    shadowColor: Colors.black,
    colorScheme: ColorScheme.light(
      onBackground: Colors.black54,
      onSurface: Colors.black,
      surface: AppColors.white.shade400,
      inverseSurface: AppColors.white.shade50,
      surfaceVariant: AppColors.white.shade600,
      secondary: AppColors.lightGreen,
      secondaryContainer: AppColors.darkGreen,
      primaryContainer: AppColors.lightBlue.shade600,
      // light shadow color
      shadow: Colors.white,
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.lightBlue.shade600,
      ),
    ),
    textTheme: textTheme,
    primaryTextTheme: lightPrimaryTextTheme,
  );
}

ThemeData darkTheme(String fontFamily) {
  final textTheme = darkTextTheme;
  return ThemeData(
    backgroundColor: AppColors.black.shade400, fontFamily: fontFamily,
    primaryColor: AppColors.blueGreen,
    primaryColorDark: AppColors.blueGreen.shade700,
    primaryColorLight: AppColors.blueGreen.shade300,
    cardColor: AppColors.blueGreen.shade700,
    scaffoldBackgroundColor: AppColors.black.shade400,

    // dark shadow color
    shadowColor: Colors.black,
    colorScheme: ColorScheme.dark(
      onBackground: Colors.white54,
      onSurface: Colors.white,
      surface: AppColors.black.shade300,
      inverseSurface: AppColors.black.shade50,
      surfaceVariant: AppColors.black.shade100,
      secondary: AppColors.red,
      secondaryContainer: AppColors.darkRed,
      primaryContainer: AppColors.blueGreen.shade600,
      // light shadow color
      shadow: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black.shade400,
      elevation: 0,
      foregroundColor: Colors.white,
      surfaceTintColor: AppColors.blueGreen,
      titleTextStyle: textTheme.headlineSmall,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.blueGreen.shade600,
        onPrimary: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.blueGreen.shade600,
      ),
    ),
    textTheme: textTheme,
    primaryTextTheme: darkPrimaryTextTheme,
  );
}
