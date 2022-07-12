import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PausePlayAnimatedIcon extends StatefulWidget {
  const PausePlayAnimatedIcon({
    Key? key,
    required this.showPlayIcon,
  }) : super(key: key);
  final bool showPlayIcon;

  @override
  State<PausePlayAnimatedIcon> createState() => _PausePlayAnimatedIconState();
}

class _PausePlayAnimatedIconState extends State<PausePlayAnimatedIcon>
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

  void startAnimation() {
    if (widget.showPlayIcon) {
      iconAnimationController.forward();
    } else {
      iconAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    startAnimation();
    return AnimatedIcon(
      icon: AnimatedIcons.pause_play,
      progress: iconAnimationController,
      color: Colors.black,
      size: 50.r,
    );
  }
}
