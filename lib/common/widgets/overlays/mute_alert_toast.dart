import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/overlays/app_toast.dart';

void showMuteAlertToastMessage(BuildContext context) {
  final theme = context.theme;
  AppToast.custom(
    context,
    title: Row(
      children: [
        Icon(
          Icons.volume_off,
          color: theme.colorScheme.onBackground,
          size: 30.r,
        ),
        8.horizontalSpace,
        Text(
          context.localization.soundSettingsMuteMessage,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    ),
  );
}
