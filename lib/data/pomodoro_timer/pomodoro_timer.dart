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
    pomodoroStatus = initState.pomodoroStatus;
    timerStatus = initState.timerStatus;
    pomodoroRound = initState.pomodoroRound;
    currentRemainingSeconds = initState.currentRemainingDuration?.inSeconds ?? currentMaxSeconds;
    _initTimer();
  }

  final Future<void> Function(PomodoroTaskModel)? onRestartTimer;
  final Future<void> Function(PomodoroTaskModel)? onFinish;
  final PomodoroTaskModel _initState;

  late CompleteTimer _timer;
  void Function()? _listener;

  late int currentRemainingSeconds;
  late int pomodoroRound;
  late PomodoroStatus pomodoroStatus;
  late TimerStatus timerStatus;

  int get currentMaxSeconds {
    if (pomodoroStatus.isWorkTime) {
      return _initState.workDuration.inSeconds;
    } else if (pomodoroStatus.isShortBreakTime) {
      return _initState.shortBreakDuration.inSeconds;
    } else {
      return _initState.longBreakDuration.inSeconds;
    }
  }

  PomodoroTaskModel get state => _initState.copyWith(
        pomodoroRound: pomodoroRound,
        currentMaxDuration: currentMaxSeconds.seconds,
        currentRemainingDuration: currentRemainingSeconds.seconds,
        pomodoroStatus: pomodoroStatus,
        timerStatus: timerStatus,
      );

  void listen(void Function() listener) {
    _listener = listener;
  }

  void start() {
    timerStatus = TimerStatus.start;

    _timer.start();
    _listener?.call();
  }

  void stop() {
    timerStatus = TimerStatus.stop;
    _timer.stop();
  }

  void cancel() {
    timerStatus = TimerStatus.cancel;
    pomodoroStatus = PomodoroStatus.work;
    currentRemainingSeconds = currentMaxSeconds;
    _timer.cancel();
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    if (pomodoroStatus.isWorkTime) {
      pomodoroRound++;
      pomodoroStatus = PomodoroStatus.shortBreak;
    } else if (pomodoroStatus.isShortBreakTime) {
      pomodoroStatus = PomodoroStatus.work;
      if (pomodoroRound >= state.maxPomodoroRound) {
        pomodoroStatus = PomodoroStatus.longBreak;
      }
    } else if (pomodoroStatus.isLongBreakTime) {
      cancel();
      await onFinish?.call(state);
      return;
    }

    _playSound();

    currentRemainingSeconds = currentMaxSeconds;
    await onRestartTimer?.call(state);
    _timer.start();
  }

  void _playSound() {
    pomodoroStatus.isWorkTime
        ? PomodoroSoundPlayer.playWorkTime()
        : PomodoroSoundPlayer.playRestTime();
  }

  void countDownCallback(CompleteTimer timer) {
    currentRemainingSeconds--;
    _listener?.call();
    if (currentRemainingSeconds == 0) {
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
