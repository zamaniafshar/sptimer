import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/data/services/sound_player.dart';

const kSecondsOfWorkTime = Duration(seconds: 25);
const kSecondsOfRestTime = Duration(seconds: 5);

class PomodoroTimer {
  PomodoroTimer({
    this.pomodoroRound = 1,
    this.isRestTime = false,
    Duration duration = kSecondsOfWorkTime,
  }) {
    _initTimer(duration, autoStart: false);
  }
  late int maxRound;
  late CompleteTimer _timer;

  CompleteTimer? _listener;

  int pomodoroRound;
  bool isRestTime;

  Future<void> Function()? _onRestartTimer;
  VoidCallback? _onFinish;

  Duration get maxDuration =>
      isRestTime ? kSecondsOfRestTime : kSecondsOfWorkTime;

  Duration get remainingTime => maxDuration - _timer.elapsedTime;

  void onRestartTimer(Future<void> Function() value) => _onRestartTimer = value;
  void onFinish(VoidCallback value) => _onFinish = value;

  void start({
    required int maxRound,
  }) {
    maxRound = maxRound;
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
