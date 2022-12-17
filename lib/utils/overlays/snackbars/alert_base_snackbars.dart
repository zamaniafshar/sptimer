import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ScaffoldFeatureController<Widget, SnackBarClosedReason> showAlertBaseSnackBar(
  BuildContext context, {
  required Widget text,
  Widget? icon,
  List<Color>? colors,
  double? height,
}) {
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
      height: height,
      padding: EdgeInsets.all(10.r),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: colors ??
              [
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
          if (icon != null) icon,
          10.horizontalSpace,
          Expanded(
            child: text,
          ),
        ],
      ),
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
