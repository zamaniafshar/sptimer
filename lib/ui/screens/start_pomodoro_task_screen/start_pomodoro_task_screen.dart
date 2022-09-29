import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';
import 'start_pomodoro_task_screen_controller.dart';
import 'widgets/circle_animated_button/circle_animated_button.dart';
import 'widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'widgets/countdown_timer/countdown_timer.dart';

class StartPomodoroTaskScreen extends StatefulWidget {
  const StartPomodoroTaskScreen({Key? key, this.task}) : super(key: key);
  final PomodoroTaskModel? task;

  @override
  State<StartPomodoroTaskScreen> createState() => _StartPomodoroTaskScreenState();
}

class _StartPomodoroTaskScreenState extends State<StartPomodoroTaskScreen> {
  @override
  void initState() {
    if (widget.task != null) {
      final controller = Get.put(StartPomodoroTaskScreenController());
      controller.init(widget.task!);
    }
    Get.find<StartPomodoroTaskScreenController>().popScreen.listen((event) {
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StartPomodoroTaskScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.find<MainController>().onAppPaused();
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Obx(() {
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 20.h),
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
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
                  0.1,
                  0.55,
                ],
              ),
            ),
            child: const _Body(),
          );
        }),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StartPomodoroTaskScreenController controller = Get.find();
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            controller.state.title,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 5.h),
        CountdownTimer(countdownTimerController: Get.find()),
        const SizedBox(),
        const SizedBox(),
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
