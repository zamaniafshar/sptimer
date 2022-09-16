import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'circle_animated_button_controller.dart';
import '../circle_neumorphic_button.dart';
import '../custom_animated_icon.dart';

class CircleAnimatedButton extends StatelessWidget {
  const CircleAnimatedButton({
    required this.controller,
    this.onStart,
    this.onPause,
    this.onResume,
    this.onFinish,
    super.key,
  });

  final CircleAnimatedButtonController controller;
  final VoidCallback? onStart;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback? onFinish;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: GetBuilder<CircleAnimatedButtonController>(
        init: controller,
        global: false,
        builder: (controller) => Stack(
          children: [
            Align(
              alignment: controller.animationLeft.value,
              child: CircleNeumorphicButton(
                colors: [],
                onTap: () {
                  controller.finishAnimation();
                  onFinish?.call();
                },
                showInnerNeumorphicShape: true,
                icon: Icon(
                  Icons.stop,
                  color: Colors.black,
                  size: 50.r,
                ),
              ),
            ),
            Align(
              alignment: controller.animationRight.value,
              child: CircleNeumorphicButton(
                colors: [],
                showInnerNeumorphicShape: true,
                icon: CustomAnimatedIcon(
                  startAnimation: controller.isPaused,
                  color: Colors.black,
                  icon: AnimatedIcons.pause_play,
                ),
                onTap: () {
                  if (controller.isPaused) {
                    controller.resumeAnimation();
                    onResume?.call();
                  } else if (controller.isResumed || controller.isStarted) {
                    controller.pauseAnimation();
                    onPause?.call();
                  }
                },
              ),
            ),
            if (controller.isFinished && !controller.isAnimating)
              CircleNeumorphicButton(
                colors: [],
                onTap: () {
                  controller.startAnimation();
                  onStart?.call();
                },
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50.r,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
