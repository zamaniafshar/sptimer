import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          color: theme.colorScheme.surface,
          elevation: 7,
          borderRadius: BorderRadius.circular(15.r),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: child,
          ),
        ),
      ),
    );
  }
}
