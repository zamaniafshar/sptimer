import 'package:flutter/material.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/shadow_painter.dart';

class CircleNeumorphic extends StatelessWidget {
  const CircleNeumorphic({
    Key? key,
    this.child,
    this.radius = 0,
    this.colors,
    this.color,
    this.showInnerNeumorphicShape = false,
  }) : super(key: key);

  final Widget? child;
  final List<Color>? colors;
  final Color? color;
  final double radius;
  final bool showInnerNeumorphicShape;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    List<double>? stops = [0.4, 1];
    List<Color> opacityShadowColors = [
      theme.colorScheme.shadow.withOp(0.1),

      theme.shadowColor.withOp(0.1),
    ];
    if (showInnerNeumorphicShape) {
      stops = null;
      opacityShadowColors = [
        theme.shadowColor.withOp(0.1),
        theme.colorScheme.shadow.withOp(0.1),
        theme.shadowColor.withOp(0.1),
      ];
    }

    final lightShadow = theme.colorScheme.shadow.withOpacity(0.1);
    final darkShadow = theme.shadowColor.withOpacity(0.2);

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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: opacityShadowColors,
              stops: stops,
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
