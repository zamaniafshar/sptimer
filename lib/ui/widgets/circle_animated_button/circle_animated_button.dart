import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'circle_animated_button_controller.dart';
import 'widgets/circle_neumorphic_button.dart';
import 'widgets/pause_play_animated_icon.dart';

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
            CircleNeumorphicButton(
              alignment: controller.animationLeft.value,
              color: const Color(0xFFEBEBEB),
              onTap: () {
                controller.finish();
                onFinish?.call();
              },
              showInnerNeumorphicShape: true,
              icon: Icon(
                Icons.stop,
                color: Colors.black,
                size: 50.r,
              ),
            ),
            CircleNeumorphicButton(
              alignment: controller.animationRight.value,
              color: const Color(0xFFEBEBEB),
              showInnerNeumorphicShape: true,
              icon: PausePlayAnimatedIcon(showPlayIcon: controller.isPaused),
              onTap: () {
                if (controller.isPaused) {
                  controller.resume();
                  onResume?.call();
                } else if (controller.isResumed || controller.isStarted) {
                  controller.pause();
                  onPause?.call();
                }
              },
            ),
            if (controller.isFinished && !controller.isAnimating)
              CircleNeumorphicButton(
                color: const Color(0xFF2bbac8),
                onTap: () {
                  controller.start();
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
