import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({
    Key? key,
    required this.startAnimation,
    required this.color,
    required this.icon,
  }) : super(key: key);
  final bool startAnimation;
  final Color color;
  final AnimatedIconData icon;

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
    );
    super.initState();
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    if (widget.startAnimation) {
      iconAnimationController.forward();
    } else {
      iconAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    startAnimation();
    return AnimatedIcon(
      icon: widget.icon,
      progress: iconAnimationController,
      color: widget.color,
      size: 50.r,
    );
  }
}
