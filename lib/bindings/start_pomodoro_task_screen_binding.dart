import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'package:pomotimer/ui/widgets/countdown_timer/countdown_timer_controller.dart';
import 'package:pomotimer/ui/widgets/custom_slider/custom_slider_controller.dart';

class StartPomodoroTaskScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CountdownTimerController());
    Get.put(CustomSliderController());
    Get.put(CircleAnimatedButtonController());
    Get.put(StartPomodoroTaskScreenController());
  }
}
