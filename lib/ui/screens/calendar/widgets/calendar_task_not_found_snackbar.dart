import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/localization/app_localization.dart';

import '../../../../utils/overlays/snackbars/alert_base_snackbars.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showCalendarTaskNotFoundSnackBar(
    BuildContext context) {
  final theme = Theme.of(context);
  final appTexts = AppLocalization.of(context);

  return showAlertBaseSnackBar(
    context,
    height: 70.h,
    text: Text(
      appTexts.calendarScreenNoRecordedTasksFound,
      style: theme.textTheme.bodyMedium,
    ),
    icon: Icon(
      Icons.info_outline,
      color: theme.colorScheme.onBackground,
      size: 40.r,
    ),
  );
}
