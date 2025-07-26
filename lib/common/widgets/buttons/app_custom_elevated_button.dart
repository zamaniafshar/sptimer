import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class AppCustomElevatedButton extends StatelessWidget {
  const AppCustomElevatedButton({
    super.key,
    required this.onPressed,
    this.gradient,
    this.height,
    this.width,
    this.child,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  final Gradient? gradient;
  final Widget? child;
  final double? height;
  final double? width;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(15.r);

    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: br,
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.theme.primaryColorLight,
                context.theme.primaryColorDark,
              ],
            ),
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor.withValues(alpha: 0.3),
            offset: const Offset(0, 3),
            blurRadius: 5.r,
          ),
        ],
      ),
      child: Material(
        borderRadius: br,
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          borderRadius: br,
          onTap: onPressed,
          child: DefaultTextStyle(
            style: context.theme.textTheme.labelLarge!.copyWith(
              color: context.theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  child ?? SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
