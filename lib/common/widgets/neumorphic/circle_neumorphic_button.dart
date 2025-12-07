import 'package:flutter/material.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/neumorphic/circle_neumorphic.dart';
import 'package:sptimer/common/widgets/shadow_painter.dart';

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
    return CircleNeumorphic(
      color: color,
      colors: colors,
      radius: radius,
      showInnerNeumorphicShape: showInnerNeumorphicShape,
      child: RawMaterialButton(
        onPressed: onTap,
        shape: const CircleBorder(),
        child: icon,
      ),
    );
  }
}
