import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/utils/utils.dart';

import 'alert_base_snackbars.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showCalendarTaskNotFoundSnackBar(
    BuildContext context) {
  final theme = Theme.of(context);
  return showAlertBaseSnackBar(
    context,
    height: 70.h,
    text: Text(
      kThereIsNoTaskFoundSnackBarText,
      style: theme.textTheme.bodyMedium,
    ),
    icon: Icon(
      Icons.info_outline,
      color: Colors.black45,
      size: 40.r,
    ),
  );
}
