import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/countdown_timer/controller/timer_animations_controller.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/countdown_timer/enum.dart';

import 'circular_rotational_lines_controller.dart';
import '../constants.dart';

class CountdownTimerController extends GetxController {
  CountdownTimerController({
    String? gradientText,
    required Duration maxDuration,
    required Duration timerDuration,
    required CountdownTimerStatus status,
  })  : _circularRotationalLinesController = Get.put(
          CircularRotationalLinesController(status: status),
        ),
        _timerAnimationsController = Get.put(
          TimerAnimationsController(
            maxDuration: maxDuration,
            timerDuration: timerDuration,
          ),
        );

  late final CircularRotationalLinesController _circularRotationalLinesController;
  late final TimerAnimationsController _timerAnimationsController;

  String? _gradientText;

  String? get gradientText => _gradientText;

  set gradientText(String? text) {
    _gradientText = text;
    update([kGradientText_getbuilder]);
  }

  set maxDuration(Duration maxDuration) {
    _timerAnimationsController.maxDuration = maxDuration;
  }

  @override
  void onClose() {
    Get.delete<CircularRotationalLinesController>();
    Get.delete<TimerAnimationsController>();
    super.onClose();
  }

  void changeStatus(CountdownTimerStatus status) {
    _circularRotationalLinesController.changeStatus(status);
  }

  void setTimerDuration(Duration value) {
    _timerAnimationsController.setTimerDuration(value);
  }

  Future<void> restart() async {
    await _timerAnimationsController.restart();
  }
}
