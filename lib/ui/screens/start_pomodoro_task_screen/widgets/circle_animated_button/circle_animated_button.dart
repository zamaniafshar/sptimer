import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'constant.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

import 'circle_animated_button_controller.dart';

class CircleAnimatedButton extends StatelessWidget {
  const CircleAnimatedButton({
    this.onStart,
    this.onPause,
    this.onResume,
    this.onFinish,
    this.onRestart,
    super.key,
  });

  final VoidCallback? onStart;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback? onFinish;
  final VoidCallback? onRestart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 100.h,
        width: 270,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            GetBuilder<CircleAnimatedButtonController>(
              id: kCancelButton_getbuilderKey,
              builder: (controller) {
                return Align(
                  alignment: controller.animationRight.value!,
                  child: CircleNeumorphicButton(
                    showInnerNeumorphicShape: true,
                    radius: 75.r,
                    color: theme.colorScheme.surface,
                    onTap: () {
                      if (controller.inProgress) return;
                      controller.finishAnimation();
                      onFinish?.call();
                    },
                    icon: Icon(
                      Icons.stop,
                      color: Colors.black54,
                      size: 50.r,
                    ),
                  ),
                );
              },
            ),
            GetBuilder<CircleAnimatedButtonController>(
              id: kRestartButton_getbuilderKey,
              builder: (controller) {
                return Align(
                  alignment: controller.animationLeft.value!,
                  child: CircleNeumorphicButton(
                    radius: 75.r,
                    showInnerNeumorphicShape: true,
                    color: theme.colorScheme.surface,
                    onTap: () {
                      if (controller.inProgress) return;
                      controller.inProgress = true;
                      controller.restartAnimation();
                      onRestart?.call();
                    },
                    icon: AnimatedRotation(
                      duration: const Duration(milliseconds: 500),
                      turns: controller.turns,
                      onEnd: () {
                        controller.inProgress = false;
                      },
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black54,
                        size: 50.r,
                      ),
                    ),
                  ),
                );
              },
            ),
            GetBuilder<CircleAnimatedButtonController>(
              id: kMainButton_getbuilderKey,
              builder: (controller) {
                return CircleNeumorphicButton(
                  radius: 100.r,
                  colors: [
                    theme.primaryColorLight,
                    theme.primaryColorDark,
                  ],
                  icon: CustomAnimatedIcon(
                    showSecondIcon: controller.showPlayIcon,
                    color: Colors.white,
                    icon: AnimatedIcons.pause_play,
                    onAnimationDone: () {
                      controller.inProgress = false;
                    },
                  ),
                  onTap: () {
                    if (controller.inProgress) return;
                    controller.inProgress = true;
                    if (controller.isFinished) {
                      controller.startAnimation();
                      onStart?.call();
                      return;
                    }
                    if (controller.isPaused) {
                      controller.resumeAnimation();
                      onResume?.call();
                    } else if (controller.isResumed || controller.isStarted) {
                      controller.pauseAnimation();
                      onPause?.call();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
