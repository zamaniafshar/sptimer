import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/services/sound_player/sound_player.dart';

const kDurationOfWorkTime = Duration(seconds: 25);
const kDurationOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    this.onRestartTimer,
    this.onFinish,
    PomodoroTimerModel? data,
  })  : _isWorkTime = data?.isWorkTime ?? true,
        _pomodoroRound = data?.pomodoroRound ?? 1 {
    _initTimer(
      data?.remainingDuration ?? kDurationOfWorkTime,
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

  Duration get maxDuration => _isWorkTime ? kDurationOfWorkTime : kDurationOfRestTime;

  Duration get remainingDuration => maxDuration - _timer.elapsedTime;

  void start([int? newMaxRound]) {
    _maxRound = newMaxRound ?? _maxRound;
    _timer.start();
    _listener?.start();
  }

  void stop() {
    _timer.stop();
    _listener?.stop();
  }

  void cancel() {
    _timer.cancel();
    _listener?.cancel();
    _isWorkTime = true;
    _pomodoroRound = 1;
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
