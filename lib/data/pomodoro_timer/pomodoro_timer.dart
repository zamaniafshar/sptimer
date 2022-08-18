import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

const kDurationOfWorkTime = Duration(seconds: 25);
const kDurationOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    this.onRestartTimer,
    this.onFinish,
  }) {
    _initTimer();
  }

  final Future<void> Function()? onRestartTimer;
  final VoidCallback? onFinish;

  late CompleteTimer _timer;

  int _pomodoroRound = 1;
  bool _isWorkTime = true;
  int? _maxRound;
  int _elapsedSeconds = 0;
  void Function()? _listener;

  int get pomodoroRound => _pomodoroRound;
  int? get maxRound => _maxRound;
  bool get isWorkTime => _isWorkTime;
  bool get isStarted => _timer.isRunning;
  Duration get maxDuration => _isWorkTime ? kDurationOfWorkTime : kDurationOfRestTime;

  Duration get remainingDuration => maxDuration - Duration(seconds: _elapsedSeconds);

  void listen(void Function() listener) {
    _listener = listener;
  }

  void start([int? newMaxRound]) {
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
  }

  Future<void> _onTimerFinish() async {
    _timer.cancel();
    _isWorkTime = !_isWorkTime;
    _playSound();
    if (_isWorkTime) _pomodoroRound++;

    if (_pomodoroRound >= _maxRound! && !_isWorkTime) {
      cancel();
      onFinish?.call();
      return;
    }
    await onRestartTimer?.call();
    _timer.start();
  }

  void _playSound() {
    _isWorkTime ? PomodoroSoundPlayer.playWorkTime() : PomodoroSoundPlayer.playRestTime();
  }

  void a(CompleteTimer timer) {
    _elapsedSeconds++;
    _listener?.call();
    if (remainingDuration.inSeconds == 0) {
      _onTimerFinish();
      _elapsedSeconds = 0;
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
