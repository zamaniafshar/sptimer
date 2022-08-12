import 'controller/rounded_rotational_lines_controller.dart';
import 'controller/timer_animations_controller.dart';

class CountdownTimerController {
  final RoundedRotationalLinesController roundedRotationalLinesController =
      RoundedRotationalLinesController();

  final TimerAnimationsController timerAnimationsController =
      TimerAnimationsController();

  Duration get remainingDuration => timerAnimationsController.remainingDuration;

  set maxDuration(Duration value) =>
      timerAnimationsController.maxDuration = value;

  set remainingDuration(Duration value) =>
      timerAnimationsController.remainingDuration = value;

  Future<void> restart() async {
    await timerAnimationsController.cancel();
    timerAnimationsController.start();
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
