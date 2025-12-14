import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class AppNeumorphicSlider extends StatelessWidget {
  const AppNeumorphicSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return NeumorphicSlider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      thumb: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.onPrimary,
          shape: BoxShape.circle,
        ),
        child: Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
      style: SliderStyle(
        accent: context.theme.colorScheme.primary,
        // variant: context.theme.colorScheme.onPrimary,
      ),
    );
  }
}
