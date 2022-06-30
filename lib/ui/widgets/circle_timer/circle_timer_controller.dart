import 'package:get/get.dart';
import 'package:pomotimer/ui/widgets/circle_timer/controller/rounded_rotational_lines_controller.dart';
import 'package:pomotimer/ui/widgets/circle_timer/controller/timer_animations_controller.dart';

// this is the main controller which you can control the timer from anywhere
class CircleTimerController {
  CircleTimerController()
      : _timerAnimationsController = Get.put(TimerAnimationsController());

  final RoundedRotationalLinesController _roundedRotationalLinesController =
      Get.put(RoundedRotationalLinesController());
  final TimerAnimationsController _timerAnimationsController;

  int get secondsLeft => _timerAnimationsController.secondsLeft;

  void setTimer(int maxSeconds) {
    _timerAnimationsController.maxSeconds = maxSeconds;
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

  void stop() {
    _timerAnimationsController.stop();
    _roundedRotationalLinesController.stop();
  }
}
