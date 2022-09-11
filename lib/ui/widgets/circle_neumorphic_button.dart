import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/app_colors.dart';

class CircleNeumorphicButton extends StatelessWidget {
  const CircleNeumorphicButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.showInnerNeumorphicShape = false,
    this.height,
    this.width,
  }) : super(key: key);

  final Widget icon;
  final Color color;
  final double? height;
  final double? width;
  final bool showInnerNeumorphicShape;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff3ada9a),
            Color(0xff00a355),
          ],
        ),
      ),
      child: icon,
    );
  }
}
