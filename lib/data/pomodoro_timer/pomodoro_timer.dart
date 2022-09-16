import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/models/pomodoro_model.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

const kDurationOfWorkTime = Duration(seconds: 25);
const kDurationOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    PomodoroModel? initData,
    this.onRestartTimer,
    this.onFinish,
  })  : _isWorkTime = initData?.isWorkTime ?? true,
        _maxRound = initData?.maxRound,
        _pomodoroRound = initData?.pomodoroRound ?? 1 {
    _remainingSeconds = initData?.remainingDuration.inSeconds ?? _maxSeconds;
    _initTimer();
  }

  final Future<void> Function(PomodoroModel)? onRestartTimer;
  final Future<void> Function(PomodoroModel)? onFinish;

  late CompleteTimer _timer;

  int _pomodoroRound;
  bool _isWorkTime;
  late int _remainingSeconds;
  int? _maxRound;
  void Function()? _listener;

  int get _maxSeconds => (isWorkTime ? kDurationOfWorkTime : kDurationOfRestTime).inSeconds;
  int get pomodoroRound => _pomodoroRound;
  int? get maxRound => _maxRound;
  bool get isWorkTime => _isWorkTime;
  bool get isStarted => _timer.isRunning;
  Duration get maxDuration => _isWorkTime ? kDurationOfWorkTime : kDurationOfRestTime;
  Duration get remainingDuration => Duration(seconds: _remainingSeconds);

  PomodoroModel get data => PomodoroModel(
        remainingDuration: remainingDuration,
        maxDuration: maxDuration,
        maxRound: maxRound,
        pomodoroRound: pomodoroRound,
        isWorkTime: isWorkTime,
      );

  void listen(void Function() listener) {
    _listener = listener;
  }

  void start([int? newMaxRound]) {
    print('started');
    _maxRound = newMaxRound ?? _maxRound;
    _timer.start();
    _listener?.call();
  }

  void stop() {
    _timer.stop();
  }

  void cancel() {
    _timer.cancel();
    _isWorkTime = true;
    _pomodoroRound = 1;
    _remainingSeconds = _maxSeconds;
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    _isWorkTime = !_isWorkTime;
    _playSound();
    if (_isWorkTime) _pomodoroRound++;

    if (_pomodoroRound >= _maxRound! && !_isWorkTime) {
      cancel();
      await onFinish?.call(data);
      return;
    }
    _remainingSeconds = _maxSeconds;
    await onRestartTimer?.call(data);
    _timer.start();
  }

  void _playSound() {
    _isWorkTime ? PomodoroSoundPlayer.playWorkTime() : PomodoroSoundPlayer.playRestTime();
  }

  void a(CompleteTimer timer) {
    print('hey hey');
    _remainingSeconds--;
    _listener?.call();
    if (_remainingSeconds == 0) {
      _onTimerFinish();
      _listener?.call();
    }
  }

  void _initTimer() {
    _timer = CompleteTimer(
      duration: const Duration(seconds: 1),
      callback: a,
      autoStart: false,
      periodic: true,
    );
  }
}
