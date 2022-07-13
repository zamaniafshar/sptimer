import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class TimerAnimationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController _timerAnimationController;

  int _maxSeconds = 25;
  int _secondsLeft = 25;
  bool _isTimerStarted = false;

  set maxSeconds(int value) {
    _maxSeconds = value;
    _secondsLeft = value;
  }

  set _setSecondsLeft(int value) {
    if (_secondsLeft == value) return;
    _secondsLeft = value;
    update([text_getbuilder]);
  }

  int get remainingSeconds => _secondsLeft;
  double get circularLineDeg => _timerAnimationController.value * 360;
  bool get isTimerStarted => _isTimerStarted;

  @override
  void onInit() {
    _timerAnimationController = AnimationController(
      vsync: this,
      duration: _maxSeconds.seconds,
      value: 1.0,
    );
    _timerAnimationController.addListener(_timerAnimationListener);
    super.onInit();
  }

  void _timerAnimationListener() {
    update([circularLine_getbuilder]);
    _setSecondsLeft = (_maxSeconds * _timerAnimationController.value).round();
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
