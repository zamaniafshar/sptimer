import 'package:complete_timer/complete_timer.dart';
import 'package:pomotimer/data/enums/pomodoro_status.dart';
import 'package:pomotimer/data/enums/timer_status.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/pomodoro_sound_player/pomodoro_sound_player.dart';

class PomodoroTimer {
  void Function()? _listener;
  Future<void> Function()? _onRoundFinish;
  Future<void> Function()? _onFinish;

  late CompleteTimer _timer;
  late Duration _intervalTime;
  late int _pomodoroRound;
  late int _maxPomodoroRound;
  late Duration _remainingDuration;
  late Duration _longBreakDuration;
  late Duration _shortBreakDuration;
  late Duration _workDuration;
  late PomodoroStatus _pomodoroStatus;
  late TimerStatus _timerStatus;

  TimerStatus get timerStatus => _timerStatus;
  PomodoroStatus get pomodoroStatus => _pomodoroStatus;
  int get pomodoroRound => _pomodoroRound;
  Duration get remainingDuration => _remainingDuration;

  Duration get currentMaxDuration {
    if (_pomodoroStatus.isWorkTime) {
      return _workDuration;
    } else if (_pomodoroStatus.isShortBreakTime) {
      return _shortBreakDuration;
    } else {
      return _longBreakDuration;
    }
  }

  void init({
    required PomodoroTaskModel initState,
    required Duration intervalTime,
    Future<void> Function()? onRoundFinish,
    Future<void> Function()? onFinish,
  }) {
    _intervalTime = intervalTime;
    _pomodoroStatus = initState.pomodoroStatus;
    _timerStatus = initState.timerStatus;
    _pomodoroRound = initState.pomodoroRound;
    _workDuration = initState.workDuration;
    _longBreakDuration = initState.longBreakDuration;
    _shortBreakDuration = initState.shortBreakDuration;
    _maxPomodoroRound = initState.maxPomodoroRound;
    _remainingDuration = initState.remainingDuration ?? currentMaxDuration;
    _onRoundFinish = onRoundFinish;
    _onFinish = onFinish;
    _initTimer();
  }

  void listen(void Function() listener) {
    _listener = listener;
  }

  void start() {
    _timerStatus = TimerStatus.start;
    _timer.start();
  }

  void stop() {
    _timerStatus = TimerStatus.stop;
    _timer.stop();
  }

  void cancel() {
    _timerStatus = TimerStatus.cancel;
    _pomodoroStatus = PomodoroStatus.work;
    _remainingDuration = currentMaxDuration;
    _pomodoroRound = 0;
    _timer.cancel();
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    if (_pomodoroStatus.isLongBreakTime) {
      cancel();
      return _onFinish?.call();
    } else if (_pomodoroRound == _maxPomodoroRound - 1 && pomodoroStatus.isWorkTime) {
      if (_longBreakDuration == Duration.zero) {
        cancel();
        return _onFinish?.call();
      }
      _pomodoroRound = _maxPomodoroRound;
      _pomodoroStatus = PomodoroStatus.longBreak;
    } else if (_pomodoroStatus.isShortBreakTime) {
      _pomodoroRound++;
      _pomodoroStatus = PomodoroStatus.work;
    } else if (_pomodoroStatus.isWorkTime) {
      _pomodoroStatus = PomodoroStatus.shortBreak;
    }

    await _onRoundFinish?.call();
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
