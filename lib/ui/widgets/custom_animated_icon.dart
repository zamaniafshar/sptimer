import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({
    Key? key,
    required this.startAnimation,
    required this.color,
    required this.icon,
    required this.onAnimationDone,
  }) : super(key: key);
  final bool startAnimation;
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
    );
    super.initState();
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    super.dispose();
  }

  Future<void> startAnimation() async {
    if (widget.startAnimation) {
      await iconAnimationController.forward();
    } else {
      await iconAnimationController.reverse();
    }
    widget.onAnimationDone();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedIcon oldWidget) {
    if (oldWidget.startAnimation != widget.startAnimation) startAnimation();
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
