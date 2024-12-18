import 'package:flutter/material.dart';
import 'package:sptimer/utils/widgets/shadow_painter.dart';
import 'package:sptimer/utils/utils.dart';

class CircleNeumorphicButton extends StatelessWidget {
  const CircleNeumorphicButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.radius,
    this.colors,
    this.color,
    this.showInnerNeumorphicShape = false,
  }) : super(key: key);

  final Widget icon;
  final List<Color>? colors;
  final Color? color;
  final double radius;
  final bool showInnerNeumorphicShape;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final lightShadow = theme.colorScheme.shadow.withOpacity(0.2);
    final darkShadow = theme.shadowColor.withOpacity(0.2);

    List<Color> opacityShadowColors = [lightShadow, darkShadow];
    if (showInnerNeumorphicShape) {
      opacityShadowColors.insert(0, darkShadow);
      opacityShadowColors = opacityShadowColors.reversed.toList();
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CustomPaint(
          size: Size.square(radius / 1.9),
          painter: ShadowPainter(
            lightShadowColor: lightShadow,
            darkShadowColor: darkShadow,
          ),
        ),
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            gradient: colors?.getLinearGradient,
          ),
        ),
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: opacityShadowColors.getLinearGradient,
          ),
          child: RawMaterialButton(
            onPressed: onTap,
            shape: const CircleBorder(),
            child: icon,
          ),
        ),
      ],
    );
  }
}
