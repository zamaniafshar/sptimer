import 'package:get/get.dart';
import 'package:complete_timer/complete_timer.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

class PomodoroTimer {
  PomodoroTimer({
    required PomodoroTaskModel initState,
    this.onRestartTimer,
    this.onFinish,
  }) : _initState = initState {
    _pomodoroStatus = initState.pomodoroStatus;
    _timerStatus = initState.timerStatus;
    _pomodoroRound = initState.pomodoroRound;
    _currentRemainingSeconds = initState.currentRemainingDuration?.inSeconds ?? currentMaxSeconds;
    _initTimer();
  }

  final Future<void> Function(PomodoroTaskModel)? onRestartTimer;
  final Future<void> Function(PomodoroTaskModel)? onFinish;
  final PomodoroTaskModel _initState;

  late CompleteTimer _timer;
  void Function()? _listener;

  late int _currentRemainingSeconds;
  late int _pomodoroRound;
  late PomodoroStatus _pomodoroStatus;
  late TimerStatus _timerStatus;

  int get currentMaxSeconds {
    if (_pomodoroStatus.isWorkTime) {
      return _initState.workDuration.inSeconds;
    } else if (_pomodoroStatus.isShortBreakTime) {
      return _initState.shortBreakDuration.inSeconds;
    } else {
      return _initState.longBreakDuration.inSeconds;
    }
  }

  PomodoroTaskModel get state => _initState.copyWith(
        pomodoroRound: _pomodoroRound,
        currentMaxDuration: currentMaxSeconds.seconds,
        currentRemainingDuration: _currentRemainingSeconds.seconds,
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
    _currentRemainingSeconds = currentMaxSeconds;
    _timer.cancel();
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    if (_pomodoroStatus.isWorkTime) {
      _pomodoroRound++;
      _pomodoroStatus = PomodoroStatus.shortBreak;
    } else if (_pomodoroStatus.isShortBreakTime) {
      _pomodoroStatus = PomodoroStatus.work;
      if (_pomodoroRound >= state.maxPomodoroRound) {
        _pomodoroStatus = PomodoroStatus.longBreak;
      }
    } else if (_pomodoroStatus.isLongBreakTime) {
      cancel();
      await onFinish?.call(state);
      return;
    }

    _playSound();

    _currentRemainingSeconds = currentMaxSeconds;
    await onRestartTimer?.call(state);
    _timer.start();
  }

  void _playSound() {
    _pomodoroStatus.isWorkTime
        ? PomodoroSoundPlayer.playWorkTime()
        : PomodoroSoundPlayer.playRestTime();
  }

  void countDownCallback(CompleteTimer timer) {
    _currentRemainingSeconds--;
    _listener?.call();
    if (_currentRemainingSeconds == 0) {
      _onTimerFinish();
      _listener?.call();
    }
  }

  void _initTimer() {
    _timer = CompleteTimer(
      duration: const Duration(seconds: 1),
      callback: countDownCallback,
      autoStart: false,
      periodic: true,
    );
  }
}
