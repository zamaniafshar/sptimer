import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/localization/app_localization.dart';

void showBackAlertDialog(
  BuildContext context, {
  VoidCallback? onCancel,
  VoidCallback? onContinue,
}) {
  final theme = Theme.of(context);
  final appTexts = AppLocalization.of(context);
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        height: 200.h,
        width: 300.w,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appTexts.startPomodoroTaskScreenCancelTimerTitle,
              style: theme.primaryTextTheme.headlineSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onCancel?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    appTexts.startPomodoroTaskScreenCancel,
                    style: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onContinue?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    appTexts.startPomodoroTaskScreenContinue,
                    style: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
