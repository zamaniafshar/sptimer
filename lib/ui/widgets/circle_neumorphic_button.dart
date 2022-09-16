import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/util/util.dart';

class CircleNeumorphicButton extends StatelessWidget {
  const CircleNeumorphicButton({
    Key? key,
    required this.icon,
    required this.colors,
    required this.onTap,
    this.showInnerNeumorphicShape = false,
    this.radius,
  }) : super(key: key);

  final Widget icon;
  final List<Color> colors;
  final double? radius;
  final bool showInnerNeumorphicShape;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: colors.getLinearGradient,
      ),
      child: RawMaterialButton(
        onPressed: onTap,
        shape: const CircleBorder(),
        child: icon,
      ),
    );
  }
}
