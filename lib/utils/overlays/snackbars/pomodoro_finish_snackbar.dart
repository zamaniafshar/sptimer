import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/localization/app_localization.dart';

import 'alert_base_snackbars.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showPomodoroFinishSnackBar(
    BuildContext context) {
  final theme = Theme.of(context);
  final appTexts = AppLocalization.of(context);
  return showAlertBaseSnackBar(
    context,
    height: 90.h,
    text: Text(
      appTexts.startPomodoroTaskScreenPomodoroFinish,
      style: theme.textTheme.bodyLarge,
    ),
    icon: Icon(
      Icons.done,
      color: theme.colorScheme.secondary,
      size: 50.r,
    ),
  );
}
