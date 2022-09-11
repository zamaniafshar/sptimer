import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData get lightTheme => ThemeData(
      backgroundColor: AppColors.white,
      primaryColor: AppColors.lightBlue,
      primaryColorDark: AppColors.lightBlue.shade600,
      primaryColorLight: AppColors.lightBlue.shade400,
      colorScheme: ColorScheme.light(
        surface: AppColors.white.shade400,
        surfaceVariant: AppColors.white.shade600,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: AppColors.lightBlue,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
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
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontSize: 12.sp,
          color: AppColors.lightBlue.shade600.withOpacity(0.7),
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: AppColors.lightBlue.shade600.withOpacity(0.8),
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          color: AppColors.lightBlue.shade600,
        ),
        labelSmall: TextStyle(
          fontSize: 12.sp,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontSize: 22.sp,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.sp,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          color: Colors.black,
        ),
      ),
    );
ThemeData get darkTheme => ThemeData();
