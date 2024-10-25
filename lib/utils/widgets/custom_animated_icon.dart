import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({
    Key? key,
    required this.showSecondIcon,
    required this.color,
    required this.icon,
    required this.onAnimationDone,
  }) : super(key: key);
  final bool showSecondIcon;
  final Color color;
  final AnimatedIconData icon;
  final void Function() onAnimationDone;

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController iconAnimationController;

  @override
  void initState() {
    iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: widget.showSecondIcon ? 1.0 : 0.0,
    );

    super.initState();
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    super.dispose();
  }

  Future<void> startAnimation() async {
    if (widget.showSecondIcon) {
      await iconAnimationController.forward();
    } else {
      await iconAnimationController.reverse();
    }
    widget.onAnimationDone();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedIcon oldWidget) {
    if (oldWidget.showSecondIcon != widget.showSecondIcon) startAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: widget.icon,
      progress: iconAnimationController,
      color: widget.color,
      size: 60.r,
    );
  }
}
