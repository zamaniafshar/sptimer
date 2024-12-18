import 'package:flutter/material.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/widgets/permission_dialog.dart';

Future<void> showNotificationPermissionDialog(
  BuildContext context,
) async {
  final localization = context.localization;

  await showPermissionDialog(
    context,
    title: localization.permissionDialogNotificationTitle,
    description: localization.permissionDialogNotificationDescription,
    icon: Icons.notifications_active,
  );
}
