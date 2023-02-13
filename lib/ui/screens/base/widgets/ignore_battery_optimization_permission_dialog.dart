import 'package:flutter/material.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/utils/utils.dart';

Future<void> showIgnoreBatteryOptimizationPermissionDialog(
  BuildContext context,
) async {
  final appTexts = AppLocalization.of(context);
  await showPermissionDialog(
    context,
    title: appTexts.permissionDialogIgnoreBatteryOptimizeTitle,
    description: appTexts.permissionDialogIgnoreBatteryOptimizeDescription,
    icon: Icons.battery_charging_full,
  );
}
