import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/alert_base_snackbars.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showPomodoroFinishSnackBar(
    BuildContext context) {
  final theme = context.theme;
  final localization = context.localization;

  return showAlertBaseSnackBar(
    context,
    height: 90.h,
    text: Text(
      localization.pomodoroTimerFinishedMessage,
      style: theme.textTheme.bodyLarge,
    ),
    icon: Icon(
      Icons.done,
      color: theme.colorScheme.secondary,
      size: 50.r,
    ),
  );
}
