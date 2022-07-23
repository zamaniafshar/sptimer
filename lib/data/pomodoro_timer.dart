import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/services/sound_player.dart';

const kDurationOfWorkTime = Duration(seconds: 25);
const kDurationOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    this.maxRound,
    this.pomodoroRound = 1,
    this.isRestTime = false,
    Duration duration = kDurationOfWorkTime,
  }) {
    _initTimer(duration, autoStart: false);
  }
  int pomodoroRound;
  bool isRestTime;
  int? maxRound;

  late CompleteTimer _timer;
  CompleteTimer? _listener;
  Future<void> Function()? _onRestartTimer;
  VoidCallback? _onFinish;

  Duration get maxDuration =>
      isRestTime ? kDurationOfRestTime : kDurationOfWorkTime;

  Duration get remainingDuration => maxDuration - _timer.elapsedTime;

  void init({
    int? maxRound,
    Future<void> Function()? onRestartTimer,
    VoidCallback? onFinish,
  }) {
    maxRound = maxRound;
    _onRestartTimer = onRestartTimer;
    _onFinish = onFinish;
  }

  void start() {
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
    isRestTime = false;
    pomodoroRound = 1;
  }

  void _onTimerFinish(CompleteTimer timer) async {
    isRestTime = !isRestTime;
    _playSound();
    pomodoroRound++;
    if (pomodoroRound > maxRound!) {
      _listener?.cancel();
      _onFinish?.call();
      return;
    }
    await _onRestartTimer?.call();
    _initTimer(maxDuration);
  }

  void _playSound() {
    isRestTime
        ? PomodoroSoundPlayer.playRestTime()
        : PomodoroSoundPlayer.playWorkTime();
  }

  void _initTimer(Duration duration, {bool autoStart = true}) {
    _timer = CompleteTimer(
      duration: duration,
      callback: _onTimerFinish,
      autoStart: autoStart,
    );
  }
}
