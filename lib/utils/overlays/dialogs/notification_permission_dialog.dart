import 'package:flutter/material.dart';
import 'package:pomotimer/localization/app_localization.dart';
import 'permission_dialog.dart';

Future<void> showNotificationPermissionDialog(
  BuildContext context,
) async {
  final appTexts = AppLocalization.of(context);
  await showPermissionDialog(
    context,
    title: appTexts.permissionDialogNotificationTitle,
    description: appTexts.permissionDialogNotificationDescription,
    icon: Icons.notifications_active,
  );
}
