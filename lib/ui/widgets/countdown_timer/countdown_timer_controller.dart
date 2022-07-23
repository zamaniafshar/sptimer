import 'controller/rounded_rotational_lines_controller.dart';
import 'controller/timer_animations_controller.dart';

class CountdownTimerController {
  final RoundedRotationalLinesController roundedRotationalLinesController =
      RoundedRotationalLinesController();

  final TimerAnimationsController timerAnimationsController =
      TimerAnimationsController();

  Duration get remainingDuration => timerAnimationsController.remainingDuration;

  Future<void> restart() async {
    await timerAnimationsController.cancel();
    timerAnimationsController.start();
  }

  void setTimer({
    required Duration maxDuration,
    Duration? currentDuration,
  }) {
    timerAnimationsController.maxDuration = maxDuration;
    timerAnimationsController.remainingDuration =
        currentDuration ?? maxDuration;
  }

  void start() {
    timerAnimationsController.start();
    roundedRotationalLinesController.start();
  }

  void pause() {
    timerAnimationsController.pause();
    roundedRotationalLinesController.pause();
  }

  void resume() {
    timerAnimationsController.resume();
    roundedRotationalLinesController.resume();
  }

  void cancel() {
    timerAnimationsController.cancel();
    roundedRotationalLinesController.cancel();
  }
}
