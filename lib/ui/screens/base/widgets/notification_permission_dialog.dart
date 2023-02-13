import 'package:flutter/material.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import '../../../../utils/overlays/dialogs/permission_dialog.dart';

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
