import 'package:complete_timer/complete_timer.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/pomodoro_sound_player/pomodoro_sound_player.dart';

class PomodoroTimer {
  late PomodoroSoundPlayer _soundPlayer;

  void Function()? _listener;
  Future<void> Function()? _onRestartTimer;
  Future<void> Function()? _onFinish;

  late CompleteTimer _timer;
  late PomodoroTaskModel _initState;
  late Duration _intervalTime;
  late int _pomodoroRound;
  late Duration _remainingDuration;
  late PomodoroStatus _pomodoroStatus;
  late TimerStatus _timerStatus;

  TimerStatus get timerStatus => _timerStatus;
  PomodoroStatus get pomodoroStatus => _pomodoroStatus;
  int get pomodoroRound => _pomodoroRound;
  Duration get remainingDuration => _remainingDuration;

  Duration get currentMaxDuration {
    if (_pomodoroStatus.isWorkTime) {
      return _initState.workDuration;
    } else if (_pomodoroStatus.isShortBreakTime) {
      return _initState.shortBreakDuration;
    } else {
      return _initState.longBreakDuration;
    }
  }

  PomodoroTaskModel get pomodoroTask => _initState.copyWith(
        pomodoroRound: _pomodoroRound,
        currentMaxDuration: currentMaxDuration,
        remainingDuration: _remainingDuration,
        pomodoroStatus: _pomodoroStatus,
        timerStatus: _timerStatus,
      );

  void init({
    required PomodoroTaskModel initState,
    required PomodoroSoundPlayer soundPlayer,
    Duration intervalTime = const Duration(seconds: 1),
    Future<void> Function()? onRestartTimer,
    Future<void> Function()? onFinish,
  }) async {
    _initState = initState;
    _intervalTime = intervalTime;
    _pomodoroStatus = initState.pomodoroStatus;
    _timerStatus = initState.timerStatus;
    _pomodoroRound = initState.pomodoroRound;
    _remainingDuration = initState.remainingDuration ?? currentMaxDuration;
    _onRestartTimer = onRestartTimer;
    _onFinish = onFinish;
    _initTimer();
    _soundPlayer = soundPlayer;
  }

  void listen(void Function() listener) {
    _listener = listener;
  }

  void start() {
    _timerStatus = TimerStatus.start;

    _timer.start();
    _listener?.call();
  }

  void stop() {
    _timerStatus = TimerStatus.stop;
    _timer.stop();
  }

  void cancel() {
    _timerStatus = TimerStatus.cancel;
    _pomodoroStatus = PomodoroStatus.work;
    _remainingDuration = currentMaxDuration;
    _pomodoroRound = 1;
    _timer.cancel();
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    if (_pomodoroStatus.isLongBreakTime) {
      cancel();
      return _onFinish?.call();
    } else if (_pomodoroStatus.isShortBreakTime ||
        _pomodoroRound == pomodoroTask.maxPomodoroRound) {
      _pomodoroRound++;
      _pomodoroStatus = PomodoroStatus.work;
    } else if (_pomodoroStatus.isWorkTime) {
      _pomodoroStatus = PomodoroStatus.shortBreak;
    }

    if (_pomodoroRound > pomodoroTask.maxPomodoroRound) {
      _pomodoroRound = pomodoroTask.maxPomodoroRound;
      _pomodoroStatus = PomodoroStatus.longBreak;
    }

    _soundPlayer.playPomodoroSound(_pomodoroStatus);

    await _onRestartTimer?.call();
    _remainingDuration = currentMaxDuration;
    _timer.start();
  }

  Future<void> countDownCallback(CompleteTimer timer) async {
    _remainingDuration -= _intervalTime;
    _listener?.call();
    if (_remainingDuration.inMicroseconds <= 0) {
      await _onTimerFinish();
      _listener?.call();
    }
  }

  void _initTimer() {
    _timer = CompleteTimer(
      duration: _intervalTime,
      callback: countDownCallback,
      autoStart: false,
      periodic: true,
    );
  }
}
