import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/widgets/circle_start_button/circle_start_button_controller.dart';

import 'widgets/circle_neumorphic_button.dart';
import 'widgets/custom_animated_icon.dart';

class CircleStartButton extends StatelessWidget {
  const CircleStartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: GetBuilder<CircleStartButtonController>(
        builder: (controller) => Stack(
          children: [
            CircleNeumorphicButton(
              alignment: controller.animationLeft.value,
              color: const Color(0xFFEBEBEB),
              onTap: controller.finish,
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
              onTap: () {
                if (controller.isPaused) {
                  controller.resume();
                } else if (controller.isResumed || controller.isStarted) {
                  controller.pause();
                }
              },
              icon: CustomAnimatedIcon(showPlayIcon: controller.isPaused),
            ),
            if (controller.isFinished && controller.isAnimationComplete)
              CircleNeumorphicButton(
                color: const Color(0xFF2bbac8),
                onTap: controller.start,
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
