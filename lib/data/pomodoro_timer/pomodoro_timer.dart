import 'package:complete_timer/complete_timer.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';
import 'package:pomotimer/data/enum/tones.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/pomodoro_sound_player/pomodoro_sound_player.dart';

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
    _remainingDuration = initState.remainingDuration ?? currentMaxDuration;
    _initTimer();
  }

  Future<void> Function()? onRestartTimer;
  Future<void> Function()? onFinish;
  final PomodoroTaskModel _initState;
  final Duration _intervalTime;
  final PomodoroSoundPlayer _soundPlayer = PomodoroSoundPlayer();

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
  Future<bool> get isSoundPlayerMuted async =>
      (_initState.tone == Tones.none && _initState.readStatusAloud == false) ||
      await _soundPlayer.isMuted() ||
      (_initState.statusVolume == 0.0 && _initState.toneVolume == 0.0);

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
    _soundPlayer.dispose();
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    if (_pomodoroStatus.isLongBreakTime) {
      cancel();
      return onFinish?.call();
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

    _playSound();

    await onRestartTimer?.call();
    _remainingDuration = currentMaxDuration;
    _timer.start();
  }

  Future<void> _playSound() async {
    if (_initState.vibrate) {
      await _soundPlayer.vibrate();
    }
    if (await isSoundPlayerMuted) return;
    if (_initState.tone != Tones.none) {
      await _soundPlayer.setVolume(_initState.toneVolume);
      _soundPlayer.playTone(_initState.tone);
    }
    if (_initState.readStatusAloud) {
      await Future.delayed(const Duration(milliseconds: 500));
      await _soundPlayer.setVolume(_initState.toneVolume);
      await _soundPlayer.playPomodoroSound(status: pomodoroStatus);
    }
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
