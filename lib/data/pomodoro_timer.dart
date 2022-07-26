import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/services/sound_player.dart';

const kDurationOfWorkTime = Duration(seconds: 25);
const kDurationOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    required this.onRestartTimer,
    required this.onFinish,
    PomodoroTimerModel? data,
  })  : _isRestTime = data?.isRestTime ?? false,
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
  bool _isRestTime;
  int? _maxRound;
  CompleteTimer? _listener;

  Duration get maxDuration => _isRestTime ? kDurationOfRestTime : kDurationOfWorkTime;

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
    _isRestTime = false;
    _pomodoroRound = 1;
  }

  void _onTimerFinish(CompleteTimer timer) async {
    _isRestTime = !_isRestTime;
    _playSound();
    _pomodoroRound++;
    if (_pomodoroRound > _maxRound!) {
      cancel();
      onFinish?.call();
      _listener?.cancel();
      return;
    }
    await onRestartTimer?.call();
    _initTimer(maxDuration);
  }

  void _playSound() {
    _isRestTime ? PomodoroSoundPlayer.playRestTime() : PomodoroSoundPlayer.playWorkTime();
  }

  void _initTimer(Duration duration, {bool autoStart = true}) {
    _timer = CompleteTimer(
      duration: duration,
      callback: _onTimerFinish,
      autoStart: autoStart,
    );
  }
}
