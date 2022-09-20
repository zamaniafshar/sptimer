import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class TimerAnimationsController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController _timerAnimationController;

  Duration _maxDuration = Duration.zero;
  Duration _remainingDuration = Duration.zero;
  bool _isTimerStarted = false;

  Duration get remainingDuration => _remainingDuration;
  double get circularLineDeg => _timerAnimationController.value * 360;
  bool get isTimerStarted => _isTimerStarted;

  set maxDuration(Duration value) {
    _maxDuration = value;
    _timerAnimationController.duration = value;
  }

  set remainingDuration(Duration value) {
    _setRemainingDuration = value;
    _timerAnimationController.value =
        _remainingDuration.inMicroseconds / _maxDuration.inMicroseconds;
  }

  set _setRemainingDuration(Duration value) {
    if (_remainingDuration == value) return;
    _remainingDuration = value;
    update([countdownText_getbuilder]);
  }

  @override
  void onInit() {
    _timerAnimationController = AnimationController(
      vsync: this,
      duration: _maxDuration,
      value: 1.0,
    );
    _timerAnimationController.addListener(_timerAnimationListener);
    super.onInit();
  }

  @override
  void onClose() {
    _timerAnimationController.dispose();
    super.onClose();
  }

  void _timerAnimationListener() {
    update([circularLine_getbuilder]);
    _setRemainingDuration = _maxDuration * _timerAnimationController.value;
  }

  void start() {
    _isTimerStarted = true;
    _timerAnimationController.reverse();
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
