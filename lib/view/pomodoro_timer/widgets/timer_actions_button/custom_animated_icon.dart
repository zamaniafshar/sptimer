import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedPlayPauseIcon extends StatefulWidget {
  const AnimatedPlayPauseIcon({
    Key? key,
    required this.showPlay,
  }) : super(key: key);
  final bool showPlay;

  @override
  State<AnimatedPlayPauseIcon> createState() => _AnimatedPlayPauseIconState();
}

class _AnimatedPlayPauseIconState extends State<AnimatedPlayPauseIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController iconAnimationController;

  @override
  void initState() {
    iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: widget.showPlay ? 1.0 : 0.0,
    );

    super.initState();
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    super.dispose();
  }

  Future<void> startAnimation() async {
    if (widget.showPlay) {
      await iconAnimationController.forward();
    } else {
      await iconAnimationController.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedPlayPauseIcon oldWidget) {
    if (oldWidget.showPlay != widget.showPlay) startAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: AnimatedIcons.pause_play,
      progress: iconAnimationController,
      color: Colors.white,
      size: 60.r,
    );
  }
}
