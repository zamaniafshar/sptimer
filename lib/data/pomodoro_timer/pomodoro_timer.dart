import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

const kDurationOfWorkTime = Duration(seconds: 25);
const kDurationOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    this.onRestartTimer,
    this.onFinish,
  })  : _isWorkTime = true,
        _pomodoroRound = 1 {
    _initTimer(
      kDurationOfWorkTime,
      autoStart: false,
    );
  }

  final Future<void> Function()? onRestartTimer;
  final VoidCallback? onFinish;

  late CompleteTimer _timer;

  int _pomodoroRound;
  bool _isWorkTime;
  int? _maxRound;
  CompleteTimer? _listener;

  int get pomodoroRound => _pomodoroRound;
  int? get maxRound => _maxRound;
  bool get isWorkTime => _isWorkTime;
  bool get isStarted => _timer.isRunning;
  Duration get maxDuration => _isWorkTime ? kDurationOfWorkTime : kDurationOfRestTime;

  Duration get remainingDuration => maxDuration - _timer.elapsedTime;

  void listenEvery(Duration duration, void Function() listener) {
    _listener = CompleteTimer(
      duration: duration,
      callback: (_) => listener(),
      autoStart: false,
      periodic: true,
    );
    if (_timer.isRunning) _listener!.start();
  }

  void start([int? newMaxRound]) {
    print('Pomodoro Timer started');
    _maxRound = newMaxRound ?? _maxRound;
    _timer.start();
    _listener?.start();
  }

  void stop() {
    _timer.stop();
    _listener?.stop();
  }

  void cancel() {
    print('Pomodoro Timer canceled');
    _timer.cancel();
    _listener?.cancel();
    _isWorkTime = true;
    _pomodoroRound = 1;
    _initTimer(maxDuration, autoStart: false);
  }

  void _onTimerFinish(CompleteTimer timer) async {
    _isWorkTime = !_isWorkTime;
    _playSound();
    if (_isWorkTime) _pomodoroRound++;

    if (_pomodoroRound >= _maxRound! && !_isWorkTime) {
      cancel();
      onFinish?.call();
      _listener?.cancel();
      return;
    }
    await onRestartTimer?.call();
    _initTimer(maxDuration);
  }

  void _playSound() {
    _isWorkTime ? PomodoroSoundPlayer.playWorkTime() : PomodoroSoundPlayer.playRestTime();
  }

  void _initTimer(Duration duration, {bool autoStart = true}) {
    _timer = CompleteTimer(
      duration: duration,
      callback: _onTimerFinish,
      autoStart: autoStart,
    );
  }
}
