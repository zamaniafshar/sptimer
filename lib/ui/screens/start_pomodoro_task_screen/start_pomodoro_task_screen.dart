import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';
import 'start_pomodoro_task_screen_controller.dart';
import 'widgets/circle_animated_button/circle_animated_button.dart';
import 'widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'widgets/countdown_timer/countdown_timer.dart';

class StartPomodoroTaskScreen extends StatelessWidget {
  const StartPomodoroTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 20.h),
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Get.find<StartPomodoroTaskScreenController>().showLinerGradientColors.value
                    ? const Color(0xFFBFDDE2)
                    : const Color(0xFFEBE8E8),
                const Color(0xFFECECEC),
              ],
              stops: const [
                0.0,
                0.55,
              ],
            ),
          ),
          child: const _Body(),
        );
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PomodoroTaskModel task = Get.arguments;
    final StartPomodoroTaskScreenController controller = Get.find();
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            task.title,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 5.h),
        CountdownTimer(countdownTimerController: Get.find()),
        const SizedBox(),
        const CustomSlider(),
        CircleAnimatedButton(
          controller: Get.find<CircleAnimatedButtonController>(),
          onStart: () {},
          onPause: controller.onPause,
          onResume: controller.onResume,
          onFinish: controller.onCancel,
        ),
      ],
    );
  }
}
