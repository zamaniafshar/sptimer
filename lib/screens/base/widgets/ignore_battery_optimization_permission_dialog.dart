import 'package:flutter/material.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/widgets/permission_dialog.dart';

Future<void> showIgnoreBatteryOptimizationPermissionDialog(
  BuildContext context,
) async {
  final localization = context.localization;

  await showPermissionDialog(
    context,
    title: localization.permissionDialogIgnoreBatteryOptimizeTitle,
    description: localization.permissionDialogIgnoreBatteryOptimizeDescription,
    icon: Icons.battery_charging_full,
  );
}
