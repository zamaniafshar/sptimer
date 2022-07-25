import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer.dart';
import 'package:pomotimer/ui/screens/home/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

class UiController {
  final CustomSliderController _sliderController = Get.find();
  final CountdownTimerController _countdownTimerController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();
  final CircleAnimatedButtonController _circleAnimatedButtonController =
      Get.find();

  late PomodoroTimer _pomodoroTimer;

  void init(PomodoroTimerModel? data) {
    _pomodoroTimer = PomodoroTimer(
      data: data,
      onRestartTimer: onPomodoroTimerRestart,
      onFinish: onPomodoroTimerFinish,
    );
    _countdownTimerController.setTimer(
      maxDuration: _pomodoroTimer.maxDuration,
      remainingDuration: _pomodoroTimer.remainingDuration,
    );
    if (data != null) {
      // Todo
    }
  }

  void onStart() {
    _countdownTimerController.start();
    _pomodoroTimer.start(_sliderController.sliderValue.toInt());
    _homeScreenController.showGradiantColor(true);
    _sliderController.deactivate();
  }

  void onPause() {
    _countdownTimerController.pause();
    _pomodoroTimer.stop();
  }

  void onResume() {
    _countdownTimerController.resume();
    _pomodoroTimer.start();
  }

  void onPomodoroTimerFinish() {
    _countdownTimerController.setTimer(maxDuration: _pomodoroTimer.maxDuration);
    _countdownTimerController.cancel();
    _circleAnimatedButtonController.finishAnimation();
    _homeScreenController.showGradiantColor(false);
    _sliderController.activate();
  }

  Future<void> onPomodoroTimerRestart() async {
    _countdownTimerController.setTimer(maxDuration: _pomodoroTimer.maxDuration);
    await _countdownTimerController.restart();
  }
}
