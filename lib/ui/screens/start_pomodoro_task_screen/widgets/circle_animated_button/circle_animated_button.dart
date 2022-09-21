import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';
import 'package:pomotimer/ui/widgets/custom_animated_icon.dart';

import 'circle_animated_button_controller.dart';

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
    final theme = Theme.of(context);

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
                radius: 85.r,
                color: theme.colorScheme.surface,
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
                radius: 85.r,
                color: theme.colorScheme.surface,
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
              Align(
                alignment: Alignment.center,
                child: CircleNeumorphicButton(
                  radius: 85.r,
                  colors: [
                    theme.primaryColorLight,
                    theme.primaryColorDark,
                  ],
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
              ),
          ],
        ),
      ),
    );
  }
}
