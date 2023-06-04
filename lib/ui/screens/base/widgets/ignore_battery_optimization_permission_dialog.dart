import 'package:flutter/material.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/utils/utils.dart';

Future<void> showIgnoreBatteryOptimizationPermissionDialog(
  BuildContext context,
) async {
  final localization = AppLocalization.of(context);
  await showPermissionDialog(
    context,
    title: localization.permissionDialogIgnoreBatteryOptimizeTitle,
    description: localization.permissionDialogIgnoreBatteryOptimizeDescription,
    icon: Icons.battery_charging_full,
  );
}
