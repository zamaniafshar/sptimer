import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class AppNeumorphicSwitch extends StatelessWidget {
  const AppNeumorphicSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return NeumorphicSwitch(
      value: value,
      onChanged: onChanged,
      height: 30.h,
      style: NeumorphicSwitchStyle(
        activeThumbColor: context.theme.colorScheme.onPrimary,
        activeTrackColor: context.theme.colorScheme.primary,
      ),
    );
  }
}
