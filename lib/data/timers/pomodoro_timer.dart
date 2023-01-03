import 'package:complete_timer/complete_timer.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';

class PomodoroTimer {
  Future<void> Function()? _onRoundFinish;
  Future<void> Function()? _onFinish;

  late CompleteTimer _timer;
  late int _pomodoroRound;
  late int _maxPomodoroRound;
  late Duration _longBreakDuration;
  late Duration _shortBreakDuration;
  late Duration _timerDuration;
  late Duration _workDuration;
  late PomodoroStatus _pomodoroStatus;
  late TimerStatus _timerStatus;

  TimerStatus get timerStatus => _timerStatus;
  PomodoroStatus get pomodoroStatus => _pomodoroStatus;
  int get pomodoroRound => _pomodoroRound;
  int get maxPomodoroRound => _maxPomodoroRound;
  Duration get remainingDuration => _timerDuration - _timer.elapsedTime;

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
    Future<void> Function()? onRoundFinish,
    Future<void> Function()? onFinish,
  }) {
    _pomodoroStatus = initState.pomodoroStatus;
    _timerStatus = initState.timerStatus;
    _pomodoroRound = initState.pomodoroRound;
    _workDuration = initState.workDuration;
    _longBreakDuration = initState.longBreakDuration;
    _shortBreakDuration = initState.shortBreakDuration;
    _maxPomodoroRound = initState.maxPomodoroRound;
    _timerDuration = initState.remainingDuration ?? currentMaxDuration;
    _onRoundFinish = onRoundFinish;
    _onFinish = onFinish;
    _initTimer();
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
    _timerDuration = currentMaxDuration;
    _pomodoroRound = 0;
    _timer.cancel();
  }

  void _onTimerFinish(_) async {
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

    _timerDuration = currentMaxDuration;
    await _onRoundFinish?.call();
    _initTimer();
    _timer.start();
  }

  void _initTimer() {
    _timer = CompleteTimer(
      duration: _timerDuration,
      callback: _onTimerFinish,
      autoStart: false,
      periodic: false,
    );
  }
}
