import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'alert_base_snackbars.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showMuteAlertSnackbar(
    BuildContext context, String text,
    {double? height}) {
  final theme = context.theme;
  return showAlertBaseSnackBar(
    context,
    height: height,
    text: Text(
      text,
      style: theme.textTheme.bodyLarge,
    ),
    icon: Icon(
      Icons.volume_off,
      color: theme.colorScheme.onBackground,
      size: 40.r,
    ),
  );
}
