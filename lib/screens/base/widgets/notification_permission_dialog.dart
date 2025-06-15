import 'package:flutter/material.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/permission_dialog.dart';

Future<void> showNotificationPermissionDialog(
  BuildContext context,
) async {
  final localization = context.localization;

  await showPermissionDialog(
    context,
    title: localization.notificationPermissionTitle,
    description: localization.notificationPermissionDescription,
    icon: Icons.notifications_active,
  );
}
