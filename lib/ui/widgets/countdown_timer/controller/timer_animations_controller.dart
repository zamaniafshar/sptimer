import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class TimerAnimationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TimerAnimationsController() {
    _timerAnimationController = AnimationController(
      vsync: this,
      duration: _maxDuration,
      value: 1.0,
    );
    _timerAnimationController.addListener(_timerAnimationListener);
  }

  late final AnimationController _timerAnimationController;

  Duration _maxDuration = Duration.zero;
  Duration _remainingDuration = Duration.zero;
  bool _isTimerStarted = false;

  set maxDuration(Duration value) {
    _maxDuration = value;
    _timerAnimationController.duration = value;
    _setRemainingSeconds = value;
  }

  set _setRemainingSeconds(Duration value) {
    if (_remainingDuration == value) return;
    _remainingDuration = value;
    update([text_getbuilder]);
  }

  Duration get remainingDuration => _remainingDuration;
  double get circularLineDeg => _timerAnimationController.value * 360;
  bool get isTimerStarted => _isTimerStarted;

  void _timerAnimationListener() {
    update([circularLine_getbuilder]);
    _setRemainingSeconds = _maxDuration * _timerAnimationController.value;
  }

  void start() {
    _isTimerStarted = true;
    _timerAnimationController.reverse(from: 1.0);
  }

  void pause() {
    _timerAnimationController.stop();
  }

  void resume() {
    _timerAnimationController.reverse();
  }

  Future<void> cancel() async {
    _isTimerStarted = false;
    await _timerAnimationController.animateTo(1.0, duration: 500.milliseconds);
  }
}
