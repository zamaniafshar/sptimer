import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';
import 'package:pomotimer/util/util.dart';

class StartPomodoroTaskScreenController {
  final CustomSliderController _sliderController = Get.find();
  final CountdownTimerController _countdownTimerController = Get.find();
  final CircleAnimatedButtonController _circleAnimatedButtonController = Get.find();
  final RxBool showLinerGradientColors = false.obs;

  String getPomodoroText(bool isWorkTime) => isWorkTime ? kWorkTimeText : kRestTimeText;

  void init(PomodoroTaskModel data) {
    _countdownTimerController.maxDuration = data.currentMaxDuration!;
    _countdownTimerController.remainingDuration = data.currentRemainingDuration!;
    _countdownTimerController.start(getPomodoroText(true));
    showLinerGradientColors.value = true;
    _sliderController.setSliderValue(data.pomodoroRound.toDouble());
    _sliderController.deactivate();
    _circleAnimatedButtonController.startAnimation();
  }

  void onPause() {
    _countdownTimerController.pause();
  }

  void onResume() {
    _countdownTimerController.resume();
  }

  void onCancel() {
    _countdownTimerController.cancel();
    showLinerGradientColors.value = false;
    _sliderController.activate();
  }

  void onPomodoroTimerFinish(PomodoroTaskModel data) {
    _countdownTimerController.maxDuration = data.currentMaxDuration!;
    onCancel();
    _circleAnimatedButtonController.finishAnimation();
    Get.back();
  }

  Future<void> onPomodoroTimerRestart(PomodoroTaskModel data) async {
    _countdownTimerController.maxDuration = data.currentMaxDuration!;
    await _countdownTimerController.restart(getPomodoroText(true));
  }
}
