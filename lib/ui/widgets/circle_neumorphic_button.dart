import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pomotimer/utils/utils.dart';

class CircleNeumorphicButton extends StatelessWidget {
  const CircleNeumorphicButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.colors,
    this.color,
    this.showInnerNeumorphicShape = false,
    this.radius,
    this.showNeumorphicStyle = true,
  }) : super(key: key);

  final Widget icon;
  final List<Color>? colors;
  final Color? color;
  final double? radius;
  final bool showInnerNeumorphicShape;
  final void Function() onTap;
  final bool showNeumorphicStyle;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        gradient: colors?.getLinearGradient,
      ),
      child: RawMaterialButton(
        onPressed: onTap,
        shape: const CircleBorder(),
        child: icon,
      ),
    );
    if (showNeumorphicStyle) {
      return Neumorphic(
        style: const NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          intensity: 1,
          shadowDarkColor: Color(0x55000000),
          depth: 5,
          shape: NeumorphicShape.convex,
        ),
        child: Neumorphic(
          style: showInnerNeumorphicShape
              ? const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  intensity: 0.5,
                  depth: -5,
                  shape: NeumorphicShape.convex,
                  oppositeShadowLightSource: false,
                )
              : null,
          child: child,
        ),
      );
    } else {
      return child;
    }
  }
}
