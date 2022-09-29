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

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 100.h,
        width: 270,
        child: GetBuilder<CircleAnimatedButtonController>(
          init: controller,
          global: false,
          builder: (controller) => Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleNeumorphicButton(
                  radius: 100.r,
                  colors: [
                    theme.primaryColorLight,
                    theme.primaryColorDark,
                  ],
                  icon: CustomAnimatedIcon(
                    startAnimation: controller.isPaused,
                    color: Colors.white,
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
              Align(
                alignment: controller.animationRight.value,
                child: CircleNeumorphicButton(
                  radius: 75.r,
                  color: theme.colorScheme.surface,
                  onTap: () {
                    controller.finishAnimation();
                    onFinish?.call();
                  },
                  icon: Icon(
                    Icons.stop,
                    color: Colors.black54,
                    size: 50.r,
                  ),
                ),
              ),
              Align(
                alignment: controller.animationLeft.value,
                child: CircleNeumorphicButton(
                  radius: 75.r,
                  color: theme.colorScheme.surface,
                  onTap: () {
                    controller.startAnimation();
                    onStart?.call();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black54,
                    size: 50.r,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
