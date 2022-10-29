import 'dart:async';
import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/screen_notifier_event.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/circle_animated_button/enum.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/countdown_timer/enum.dart';
import 'package:pomotimer/util/util.dart';
import 'widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'widgets/countdown_timer/controller/countdown_timer_controller.dart';

class StartPomodoroTaskScreenController extends GetxController {
  late final CountdownTimerController _countdownTimerController;
  late final CircleAnimatedButtonController _circleAnimatedButtonController;
  late final RxBool _showLinerGradientColors;
  late final Rx<String?> _pomodoroText;
  late final PomodoroTimer _timer;
  final _screenNotifier = StreamController<ScreenNotifierEvent>();

  bool get showLinerGradientColors => _showLinerGradientColors.value;
  Stream<ScreenNotifierEvent> get screenNotifier => _screenNotifier.stream;
  PomodoroTaskModel get pomodoroTask => _timer.pomodoroTask;
  String? get pomodoroText => _pomodoroText.value;
  bool get isTimerStarted => !(_timer.timerStatus.isCanceled);
  bool get isTimerStopped => _timer.timerStatus.isStopped;

  String get _getPomodoroText {
    String result;
    if (pomodoroTask.pomodoroStatus.isWorkTime) {
      result = kWorkTimeText;
    } else if (pomodoroTask.pomodoroStatus.isShortBreakTime) {
      result = kShortBreakText;
    } else {
      result = kLongBreakText;
    }
    return '$result${_timer.currentMaxDuration.inMinutes} minutes';
  }

  String get _getSubtitleText =>
      '${pomodoroTask.pomodoroRound} of ${pomodoroTask.maxPomodoroRound} Session';

  @override
  void onClose() {
    _timer.cancel();
    Get.delete<CountdownTimerController>();
    Get.delete<CircleAnimatedButtonController>();
    _screenNotifier.close();
    super.onClose();
  }

  Future<void> init(PomodoroTaskModel initState, [bool isAlreadyStarted = false]) async {
    _timer = PomodoroTimer(
      initState: initState,
      onRestartTimer: onPomodoroTimerRestart,
      onFinish: onPomodoroTimerFinish,
      intervalTime: const Duration(milliseconds: 16),
    );
    _timer.listen(() {
      _countdownTimerController.setTimerDuration(_timer.remainingDuration);
    });
    checkSoundSettings();
    if (isAlreadyStarted) {
      _countdownTimerController = Get.put(
        CountdownTimerController(
          maxDuration: _timer.currentMaxDuration,
          timerDuration: _timer.remainingDuration,
          subtitleText: _getSubtitleText,
          status: initState.timerStatus.isStopped
              ? CountdownTimerStatus.pause
              : CountdownTimerStatus.resume,
        ),
      );
      _circleAnimatedButtonController = Get.put(CircleAnimatedButtonController(
        status: initState.timerStatus.isStopped
            ? CircleAnimatedButtonStatus.pause
            : CircleAnimatedButtonStatus.started,
      ));
      _showLinerGradientColors = true.obs;
      _pomodoroText = Rx<String?>(null);
      _pomodoroText.value = _getPomodoroText;
      if (!initState.timerStatus.isStopped) _timer.start();
    } else {
      _countdownTimerController = Get.put(
        CountdownTimerController(
          maxDuration: _timer.currentMaxDuration,
          timerDuration: _timer.remainingDuration,
          status: CountdownTimerStatus.cancel,
        ),
      );
      _circleAnimatedButtonController = Get.put(CircleAnimatedButtonController());
      _showLinerGradientColors = false.obs;
      _pomodoroText = Rx<String?>(null);
      await Future.delayed(500.milliseconds);
      _startAnimations();
      _timer.start();
    }
  }

  void _startAnimations() {
    _showLinerGradientColors.value = true;
    _circleAnimatedButtonController.startAnimation();
    _countdownTimerController.changeStatus(CountdownTimerStatus.start);
    _countdownTimerController.subtitleText = _getSubtitleText;
    _pomodoroText.value = _getPomodoroText;
  }

  Future<void> onRestart() async {
    _timer.cancel();
    _countdownTimerController.maxDuration = _timer.currentMaxDuration;
    _countdownTimerController.changeStatus(CountdownTimerStatus.cancel);
    _circleAnimatedButtonController.inProgress = true;
    await _countdownTimerController.restart();
    _countdownTimerController.changeStatus(CountdownTimerStatus.start);
    _circleAnimatedButtonController.inProgress = false;
    _countdownTimerController.subtitleText = _getSubtitleText;
    _pomodoroText.value = _getPomodoroText;
    _timer.start();
  }

  void start() {
    checkSoundSettings();
    _startAnimations();
    _timer.start();
  }

  void pause() {
    _timer.stop();
    _countdownTimerController.changeStatus(CountdownTimerStatus.pause);
  }

  void resume() {
    _timer.start();
    _countdownTimerController.changeStatus(CountdownTimerStatus.resume);
  }

  void cancel() {}

  Future<void> onPomodoroTimerFinish() async {
    _countdownTimerController.maxDuration = _timer.currentMaxDuration;
    _countdownTimerController.restart();
    _countdownTimerController.changeStatus(CountdownTimerStatus.cancel);
    _circleAnimatedButtonController.finishAnimation();
    _screenNotifier.add(ScreenNotifierEvent.showPomodoroFinishSnackbar);
    _showLinerGradientColors.value = false;
    _countdownTimerController.subtitleText = null;
    _pomodoroText.value = null;
  }

  Future<void> onPomodoroTimerRestart() async {
    _circleAnimatedButtonController.inProgress = true;
    _countdownTimerController.maxDuration = _timer.currentMaxDuration;
    await _countdownTimerController.restart();
    _circleAnimatedButtonController.inProgress = false;
    _countdownTimerController.subtitleText = _getSubtitleText;
    _pomodoroText.value = _getPomodoroText;
  }

  Future<void> checkSoundSettings() async {
    if (await _timer.isSoundPlayerMuted) {
      _screenNotifier.add(ScreenNotifierEvent.showMuteAlertSnackbar);
    }
  }
}
