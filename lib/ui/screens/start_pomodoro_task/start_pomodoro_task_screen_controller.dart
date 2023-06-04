import 'dart:async';
import 'package:get/get.dart';
import 'package:sptimer/controller/app_settings_controller.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';
import 'package:sptimer/data/timers/pomodoro_task_timer.dart';
import 'package:sptimer/ui/screens/start_pomodoro_task/screen_notifier_event.dart';
import 'package:sptimer/ui/screens/start_pomodoro_task/widgets/circle_animated_button/enum.dart';
import 'package:sptimer/ui/screens/start_pomodoro_task/widgets/countdown_timer/enum.dart';
import 'widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'widgets/countdown_timer/controller/countdown_timer_controller.dart';

class StartPomodoroTaskScreenController extends GetxController {
  final _countdownTimerController = Get.put(CountdownTimerController());
  final _circleAnimatedButtonController = Get.put(CircleAnimatedButtonController());
  final _showLinerGradientColors = false.obs;
  final _pomodoroText = ''.obs;
  final _screenNotifier = StreamController<ScreenNotifierEvent>();
  final _appText = Get.find<AppSettingsController>().localization;
  late PomodoroTaskTimer _timer;

  bool get showLinerGradientColors => _showLinerGradientColors.value;
  Stream<ScreenNotifierEvent> get screenNotifier => _screenNotifier.stream;
  PomodoroTaskModel get pomodoroTask => _timer.pomodoroTask;
  String get taskTitle => _timer.taskTitle;
  String? get pomodoroText => _pomodoroText.value.isEmpty ? null : _pomodoroText.value;
  bool get isTimerStarted => !(_timer.timerStatus.isCanceled);
  bool get isTimerStopped => _timer.timerStatus.isStopped;

  String get _getPomodoroText {
    if (_timer.pomodoroStatus.isWorkTime) {
      return _appText.getWorkTimeText(_timer.currentMaxDuration);
    } else if (_timer.pomodoroStatus.isShortBreakTime) {
      return _appText.getShortBreakText(_timer.currentMaxDuration);
    } else {
      return _appText.getLongBreakText(_timer.currentMaxDuration);
    }
  }

  String get _getSubtitleText {
    int round = _timer.pomodoroRound + (_timer.pomodoroStatus.isLongBreakTime ? 0 : 1);
    return _appText.getSubtitleText(round, _timer.maxPomodoroRound);
  }

  @override
  void onClose() {
    _timer.cancel();
    _timer.dispose();
    Get.delete<CountdownTimerController>();
    Get.delete<CircleAnimatedButtonController>();
    _screenNotifier.close();
    super.onClose();
  }

  void init(PomodoroTaskTimer timer, [bool isAlreadyStarted = false]) async {
    _timer = timer;
    final initState = timer.pomodoroTask;
    _timer.listen(const Duration(milliseconds: 16), () {
      _countdownTimerController.setTimerDuration(_timer.remainingDuration);
    });
    checkSoundSettings();
    if (isAlreadyStarted) {
      _countdownTimerController.init(
        maxDuration: _timer.currentMaxDuration,
        timerDuration: _timer.remainingDuration,
        subtitleText: _getSubtitleText,
        status: initState.timerStatus.isStopped
            ? CountdownTimerStatus.pause
            : CountdownTimerStatus.resume,
      );
      _circleAnimatedButtonController.init(
        initState.timerStatus.isStopped
            ? CircleAnimatedButtonStatus.pause
            : CircleAnimatedButtonStatus.started,
      );
      _showLinerGradientColors.value = true;
      _pomodoroText.value = _getPomodoroText;
      if (initState.timerStatus.isStarted) {
        _timer.start();
      } else if (initState.timerStatus.isCanceled) {
        await Future.delayed(300.milliseconds);
        onPomodoroTimerFinish();
      }
    } else {
      _countdownTimerController.init(
        maxDuration: _timer.currentMaxDuration,
        timerDuration: _timer.remainingDuration,
        status: CountdownTimerStatus.cancel,
      );
      _circleAnimatedButtonController.init(CircleAnimatedButtonStatus.finished);

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
    await _timer.saveTaskReport();
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

  void cancel() {
    _timer.saveTaskReport();
    _timer.cancel();
  }

  Future<void> onPomodoroTimerFinish() async {
    _timer.saveTaskReport(isCompleted: true);
    _countdownTimerController.maxDuration = _timer.currentMaxDuration;
    _countdownTimerController.restart();
    _countdownTimerController.changeStatus(CountdownTimerStatus.cancel);
    _circleAnimatedButtonController.finishAnimation();
    _showLinerGradientColors.value = false;
    _countdownTimerController.subtitleText = null;
    _pomodoroText.value = '';
    _screenNotifier.add(ScreenNotifierEvent.showPomodoroFinishSnackbar);
  }

  Future<void> onPomodoroRoundFinish() async {
    checkSoundSettings();
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
