import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/utils/constants/app_texts.dart';

import 'alert_base_snackbars.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showCalendarScreenErrorSnackbar(
    BuildContext context) {
  final theme = Theme.of(context);
  return showAlertBaseSnackBar(
    context,
    height: 60.h,
    text: Text(
      kCalendarScreenError,
      style: theme.textTheme.bodyMedium,
    ),
    icon: Icon(
      Icons.error_outline,
      color: Colors.red.shade700,
      size: 40.r,
    ),
  );
}
