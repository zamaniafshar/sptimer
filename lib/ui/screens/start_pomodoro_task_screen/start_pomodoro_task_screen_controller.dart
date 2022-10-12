import 'dart:async';
import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/circle_animated_button/enum.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/countdown_timer/enum.dart';
import 'package:pomotimer/util/util.dart';
import 'widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'widgets/countdown_timer/controller/countdown_timer_controller.dart';

class StartPomodoroTaskScreenController extends GetxController {
  late final CountdownTimerController _countdownTimerController;
  late final CircleAnimatedButtonController _circleAnimatedButtonController;
  late final RxBool _showLinerGradientColors;
  late final PomodoroTimer _timer;
  final StreamController _popScreenController = StreamController();

  bool get showLinerGradientColors => _showLinerGradientColors.value;
  Stream get popScreen => _popScreenController.stream;
  PomodoroTaskModel get pomodoroTask => _timer.pomodoroTask;
  String getPomodoroText(bool isWorkTime) => isWorkTime ? kWorkTimeText : kRestTimeText;

  @override
  void onClose() {
    _timer.cancel();
    Get.delete<CountdownTimerController>();
    Get.delete<CircleAnimatedButtonController>();
    _popScreenController.close();
    super.onClose();
  }

  Future<void> init(PomodoroTaskModel initState, [bool isAlreadyStarted = false]) async {
    _timer = PomodoroTimer(
      initState: initState,
      onRestartTimer: onPomodoroTimerRestart,
      onFinish: onPomodoroTimerFinish,
      intervalTime: const Duration(milliseconds: 16),
    );
    if (isAlreadyStarted) {
      _countdownTimerController = Get.put(
        CountdownTimerController(
          maxDuration: _timer.currentMaxDuration,
          timerDuration: _timer.remainingDuration,
          gradientText: getPomodoroText(true),
          status: CountdownTimerStatus.resume,
        ),
      );
      _circleAnimatedButtonController = Get.put(CircleAnimatedButtonController(
        status: CircleAnimatedButtonStatus.started,
      ));
      _showLinerGradientColors = true.obs;
    } else {
      _countdownTimerController = Get.put(
        CountdownTimerController(
          maxDuration: _timer.currentMaxDuration,
          timerDuration: _timer.remainingDuration,
          gradientText: getPomodoroText(true),
          status: CountdownTimerStatus.cancel,
        ),
      );
      _circleAnimatedButtonController = Get.put(CircleAnimatedButtonController());
      _showLinerGradientColors = false.obs;

      await Future.delayed(500.milliseconds);
      _showLinerGradientColors.value = true;
      _circleAnimatedButtonController.startAnimation();
      _countdownTimerController.changeStatus(CountdownTimerStatus.start);
    }
    _timer.listen(() {
      _countdownTimerController.setTimerDuration(_timer.remainingDuration);
    });
    _timer.start();
  }

  Future<void> onRestart() async {
    // _circleAnimatedButtonController.isAnimating = true;
  }

  void onPause() {
    _timer.stop();
    _countdownTimerController.changeStatus(CountdownTimerStatus.pause);
  }

  void onResume() {
    _timer.start();
    _countdownTimerController.changeStatus(CountdownTimerStatus.resume);
  }

  void onCancel() {
    _timer.cancel();
    _popScreenController.sink.add(null);
  }

  Future<void> onPomodoroTimerFinish() async {
    onCancel();
  }

  Future<void> onPomodoroTimerRestart() async {
    _countdownTimerController.maxDuration = _timer.currentMaxDuration;
    await _countdownTimerController.restart();
    _countdownTimerController.gradientText = getPomodoroText(true);
  }
}
