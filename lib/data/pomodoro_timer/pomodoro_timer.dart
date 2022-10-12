import 'package:complete_timer/complete_timer.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

class PomodoroTimer {
  PomodoroTimer({
    required PomodoroTaskModel initState,
    Duration intervalTime = const Duration(seconds: 1),
    this.onRestartTimer,
    this.onFinish,
  })  : _initState = initState,
        _intervalTime = intervalTime {
    _pomodoroStatus = initState.pomodoroStatus;
    _timerStatus = initState.timerStatus;
    _pomodoroRound = initState.pomodoroRound;
    _remainingDuration = initState.currentRemainingDuration ?? currentMaxDuration;
    _initTimer();
  }

  Future<void> Function()? onRestartTimer;
  Future<void> Function()? onFinish;
  final PomodoroTaskModel _initState;
  final Duration _intervalTime;

  late CompleteTimer _timer;
  void Function()? _listener;

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
        currentRemainingDuration: _remainingDuration,
        pomodoroStatus: _pomodoroStatus,
        timerStatus: _timerStatus,
      );

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
    _timer.cancel();
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    if (_pomodoroStatus.isWorkTime) {
      _pomodoroRound++;
      _pomodoroStatus = PomodoroStatus.shortBreak;
    } else if (_pomodoroStatus.isShortBreakTime) {
      _pomodoroStatus = PomodoroStatus.work;
    } else if (_pomodoroStatus.isLongBreakTime) {
      cancel();
      return onFinish?.call();
    }

    if (_pomodoroRound >= pomodoroTask.maxPomodoroRound) {
      _pomodoroStatus = PomodoroStatus.longBreak;
    }

    _playSound();

    _remainingDuration = currentMaxDuration;
    await onRestartTimer?.call();
    _timer.start();
  }

  void _playSound() {
    _pomodoroStatus.isWorkTime
        ? PomodoroSoundPlayer.playWorkTime()
        : PomodoroSoundPlayer.playRestTime();
  }

  void countDownCallback(CompleteTimer timer) {
    _remainingDuration -= _intervalTime;
    _listener?.call();
    if (_remainingDuration.inMicroseconds <= 0) {
      _onTimerFinish();
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
