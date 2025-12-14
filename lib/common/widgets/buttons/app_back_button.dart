import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onBack,
  });

  final void Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBack ?? () => Navigator.pop(context),
      splashRadius: 24.r,
      iconSize: 24.sp,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
    );
  }
}
