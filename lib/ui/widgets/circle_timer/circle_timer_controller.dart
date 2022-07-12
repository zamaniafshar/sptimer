import 'package:get/get.dart';
import 'package:pomotimer/ui/widgets/circle_timer/controller/rounded_rotational_lines_controller.dart';
import 'package:pomotimer/ui/widgets/circle_timer/controller/timer_animations_controller.dart';

class CircleTimerController {
  CircleTimerController()
      : _timerAnimationsController = Get.put(TimerAnimationsController());

  final RoundedRotationalLinesController _roundedRotationalLinesController =
      Get.put(RoundedRotationalLinesController());
  final TimerAnimationsController _timerAnimationsController;

  int get secondsLeft => _timerAnimationsController.secondsLeft;

  Future<void> setTimer(int maxSeconds) async {
    _timerAnimationsController.maxSeconds = maxSeconds;
    await _timerAnimationsController.cancel();
    _timerAnimationsController.start();
  }

  void start() {
    _timerAnimationsController.start();
    _roundedRotationalLinesController.start();
  }

  void pause() {
    _timerAnimationsController.pause();
    _roundedRotationalLinesController.pause();
  }

  void resume() {
    _timerAnimationsController.resume();
    _roundedRotationalLinesController.resume();
  }

  void cancel() {
    _timerAnimationsController.cancel();
    _roundedRotationalLinesController.cancel();
  }
}
