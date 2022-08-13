import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/ui/screens/home/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

class UiController {
  final CustomSliderController _sliderController = Get.find();
  final CountdownTimerController _countdownTimerController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();
  final CircleAnimatedButtonController _circleAnimatedButtonController = Get.find();

  int get maxRound => _sliderController.sliderValue.toInt();

  void init(bool isStarted, PomodoroTimerModel data) {
    _countdownTimerController.maxDuration = data.maxDuration;
    _countdownTimerController.remainingDuration = data.remainingDuration;
    if (isStarted) {
      _countdownTimerController.start();
      _sliderController.sliderValue = data.maxRound.toDouble();
      _sliderController.deactivate();
      _circleAnimatedButtonController.startAnimation();
    }
  }

  void onStart() {
    _countdownTimerController.start();
    _homeScreenController.showGradiantColor(true);
    _sliderController.deactivate();
  }

  void onPause() {
    _countdownTimerController.pause();
  }

  void onResume() {
    _countdownTimerController.resume();
  }

  void onCancel() {
    _countdownTimerController.cancel();
    _homeScreenController.showGradiantColor(false);
    _sliderController.activate();
  }

  void onPomodoroTimerFinish(PomodoroTimerModel data) {
    _countdownTimerController.maxDuration = data.maxDuration;
    onCancel();
    _circleAnimatedButtonController.finishAnimation();
  }

  Future<void> onPomodoroTimerRestart(PomodoroTimerModel data) async {
    _countdownTimerController.maxDuration = data.maxDuration;
    await _countdownTimerController.restart();
  }
}
