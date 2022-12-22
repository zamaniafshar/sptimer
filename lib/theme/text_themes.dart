import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

TextTheme get lightTextTheme => TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: Colors.black54,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: Colors.black54,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.black54,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        color: Colors.black87,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        color: Colors.black87,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.black87,
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
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );

TextTheme get lightPrimaryTextTheme => TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: AppColors.lightBlue.shade600.withOpacity(0.7),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: AppColors.lightBlue.shade600.withOpacity(0.9),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: AppColors.lightBlue.shade600,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        color: AppColors.lightBlue.shade700,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        color: AppColors.lightBlue.shade700,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        color: AppColors.lightBlue.shade700,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.lightBlue.shade700,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.lightBlue.shade700,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        color: AppColors.lightBlue.shade700,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        color: AppColors.lightBlue.shade700,
        fontWeight: FontWeight.w500,
      ),
    );

TextTheme get darkTextTheme => TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: Colors.white54,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: Colors.white54,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.white54,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        color: Colors.white70,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        color: Colors.white70,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.white70,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );

TextTheme get darkPrimaryTextTheme => TextTheme(
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: AppColors.blueGreen.shade600.withOpacity(0.7),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: AppColors.blueGreen.shade600.withOpacity(0.9),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: AppColors.blueGreen.shade600,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        color: AppColors.blueGreen.shade700,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        color: AppColors.blueGreen.shade700,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        color: AppColors.blueGreen.shade700,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.blueGreen.shade700,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.blueGreen.shade700,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        color: AppColors.blueGreen.shade700,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        color: AppColors.blueGreen.shade700,
        fontWeight: FontWeight.w500,
      ),
    );
