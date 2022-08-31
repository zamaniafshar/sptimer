import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';
import 'package:pomotimer/util/util.dart';

class UiController {
  final CustomSliderController _sliderController = Get.find();
  final CountdownTimerController _countdownTimerController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();
  final CircleAnimatedButtonController _circleAnimatedButtonController = Get.find();

  String getPomodoroText(bool isWorkTime) => isWorkTime ? kWorkTimeText : kRestTimeText;

  void init(bool isStarted, PomodoroTimerModel data) {
    _countdownTimerController.maxDuration = data.maxDuration;
    _countdownTimerController.remainingDuration = data.remainingDuration;
    if (isStarted) {
      _countdownTimerController.start(getPomodoroText(data.isWorkTime));
      _homeScreenController.showGradientColor(true);
      _sliderController.setSliderValue(data.maxRound!.toDouble());
      _sliderController.deactivate();
      _circleAnimatedButtonController.startAnimation();
    }
  }

  void onStart() {
    _countdownTimerController.start(getPomodoroText(true));
    _homeScreenController.showGradientColor(true);
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
    _homeScreenController.showGradientColor(false);
    _sliderController.activate();
  }

  void onPomodoroTimerFinish(PomodoroTimerModel data) {
    onCancel();
    _circleAnimatedButtonController.finishAnimation();
  }

  Future<void> onPomodoroTimerRestart(PomodoroTimerModel data) async {
    _countdownTimerController.maxDuration = data.maxDuration;
    await _countdownTimerController.restart(getPomodoroText(data.isWorkTime));
  }
}
