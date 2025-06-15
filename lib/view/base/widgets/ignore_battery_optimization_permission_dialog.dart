import 'package:flutter/material.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/permission_dialog.dart';

Future<void> showIgnoreBatteryOptimizationPermissionDialog(
  BuildContext context,
) async {
  final localization = context.localization;

  await showPermissionDialog(
    context,
    title: localization.ignoreBatteryOptimizeTitle,
    description: localization.ignoreBatteryOptimizeDescription,
    icon: Icons.battery_charging_full,
  );
}
