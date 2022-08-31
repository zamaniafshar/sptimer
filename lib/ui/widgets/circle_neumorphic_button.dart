import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleNeumorphicButton extends StatelessWidget {
  const CircleNeumorphicButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.showInnerNeumorphicShape = false,
  }) : super(key: key);

  final Widget icon;
  final Color color;
  final bool showInnerNeumorphicShape;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        intensity: 1,
        shadowDarkColor: Color(0x55000000),
        depth: 10,
        shape: NeumorphicShape.convex,
      ),
      child: Neumorphic(
        style: showInnerNeumorphicShape
            ? null
            : const NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                intensity: 1,
                depth: -20,
                shape: NeumorphicShape.flat,
                oppositeShadowLightSource: true,
              ),
        child: MaterialButton(
          shape: const CircleBorder(),
          color: color,
          height: 100.w,
          minWidth: 100.h,
          onPressed: onTap,
          child: icon,
        ),
      ),
    );
  }
}
