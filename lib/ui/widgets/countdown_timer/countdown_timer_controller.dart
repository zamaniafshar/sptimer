import 'package:get/get.dart';

import 'controller/rounded_rotational_lines_controller.dart';
import 'controller/timer_animations_controller.dart';

class CountdownTimerController extends GetxController {
  final RoundedRotationalLinesController roundedRotationalLinesController =
      RoundedRotationalLinesController();

  final TimerAnimationsController timerAnimationsController = TimerAnimationsController();

  String? _gradientText;

  Duration get remainingDuration => timerAnimationsController.remainingDuration;

  String? get gradientText => _gradientText;

  set _setText(String? text) {
    _gradientText = text;
    update();
  }

  set maxDuration(Duration value) => timerAnimationsController.maxDuration = value;

  set remainingDuration(Duration value) => timerAnimationsController.remainingDuration = value;

  Future<void> restart(String text) async {
    await timerAnimationsController.cancel();
    timerAnimationsController.start();
    _setText = text;
  }

  void start(String text) {
    timerAnimationsController.start();
    _setText = text;
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
    _setText = null;
    roundedRotationalLinesController.cancel();
  }
}
