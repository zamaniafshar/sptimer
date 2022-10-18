import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/util/util.dart';

void showPomodoroFinishSnackBar(BuildContext context) {
  final theme = Theme.of(context);
  final snackBar = SnackBar(
    dismissDirection: DismissDirection.horizontal,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10.r),
    padding: EdgeInsets.zero,
    duration: const Duration(seconds: 5),
    elevation: 0.0,
    content: Container(
      height: 90.h,
      padding: EdgeInsets.all(10.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            theme.backgroundColor,
            theme.colorScheme.surface,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(2, 3),
            spreadRadius: 2,
            color: Colors.black26,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.done,
            color: theme.colorScheme.secondary,
            size: 50.r,
          ),
          10.horizontalSpace,
          Expanded(
            child: Text(
              kPomodoroFinishText,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
