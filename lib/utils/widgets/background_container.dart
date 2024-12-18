import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    Key? key,
    this.height,
    this.width,
    this.padding,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: theme.colorScheme.surface,
        elevation: 10,
        borderRadius: BorderRadius.circular(15.r),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: child,
        ),
      ),
    );
  }
}
