import 'package:flutter/material.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/utils/utils.dart';

Future<void> showNotificationPermissionDialog(
  BuildContext context,
) async {
  final localization = AppLocalization.of(context);
  await showPermissionDialog(
    context,
    title: localization.permissionDialogNotificationTitle,
    description: localization.permissionDialogNotificationDescription,
    icon: Icons.notifications_active,
  );
}
