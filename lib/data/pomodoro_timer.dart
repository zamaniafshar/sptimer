import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/services/sound_player.dart';

const kSecondsOfWorkTime = Duration(seconds: 25);
const kSecondsOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    required this.maxRound,
    required this.onRestartTimer,
    required this.onFinish,
    this.pomodoroRound = 1,
    this.isRestTime = false,
    Duration duration = kSecondsOfWorkTime,
  }) {
    _initTimer(duration, autoStart: false);
  }
  final int maxRound;
  final Future<void> Function() onRestartTimer;
  final VoidCallback onFinish;

  late CompleteTimer _timer;
  CompleteTimer? _listener;
  int pomodoroRound;
  bool isRestTime;

  Duration get maxDuration =>
      isRestTime ? kSecondsOfRestTime : kSecondsOfWorkTime;

  Duration get remainingTime => maxDuration - _timer.elapsedTime;

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
    if (pomodoroRound > maxRound) {
      _listener?.cancel();
      onFinish();
      return;
    }
    await onRestartTimer();
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
