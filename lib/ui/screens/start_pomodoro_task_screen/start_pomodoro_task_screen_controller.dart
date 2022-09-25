import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';
import 'package:pomotimer/util/util.dart';

import 'widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'widgets/countdown_timer/countdown_timer_controller.dart';

class StartPomodoroTaskScreenController extends GetxController {
  final CustomSliderController _sliderController = Get.put(CustomSliderController());
  final CountdownTimerController _countdownTimerController = Get.put(CountdownTimerController());
  final CircleAnimatedButtonController _circleAnimatedButtonController =
      Get.put(CircleAnimatedButtonController());
  final RxBool showLinerGradientColors = false.obs;
  late final PomodoroTimer _timer;

  PomodoroTaskModel get state => _timer.state;
  String getPomodoroText(bool isWorkTime) => isWorkTime ? kWorkTimeText : kRestTimeText;

  @override
  void onClose() {
    _timer.cancel();
    Get.delete<CustomSliderController>();
    Get.delete<CountdownTimerController>();
    Get.delete<CircleAnimatedButtonController>();
    super.onClose();
  }

  Future<void> init(PomodoroTaskModel initState) async {
    _timer = PomodoroTimer(
      initState: initState,
      onRestartTimer: onPomodoroTimerRestart,
      onFinish: onPomodoroTimerFinish,
    );
    _countdownTimerController.maxDuration = _timer.state.currentMaxDuration!;
    _countdownTimerController.remainingDuration = _timer.state.currentRemainingDuration!;
    await Future.delayed(500.milliseconds);
    _timer.start();
    _countdownTimerController.start(getPomodoroText(true));
    showLinerGradientColors.value = true;
    _sliderController.setSliderValue(_timer.state.pomodoroRound.toDouble());
    _sliderController.deactivate();
    _circleAnimatedButtonController.startAnimation();
  }

  void onPause() {
    _timer.stop();
    _countdownTimerController.pause();
  }

  void onResume() {
    _timer.start();
    _countdownTimerController.resume();
  }

  void onCancel() {
    _timer.cancel();
    _countdownTimerController.pause();
    _sliderController.activate();
    Get.back();
  }

  Future<void> onPomodoroTimerFinish(PomodoroTaskModel data) async {
    onCancel();
    _circleAnimatedButtonController.finishAnimation();
    Get.back();
  }

  Future<void> onPomodoroTimerRestart(PomodoroTaskModel data) async {
    _countdownTimerController.maxDuration = data.currentMaxDuration!;
    await _countdownTimerController.restart(getPomodoroText(true));
  }
}
