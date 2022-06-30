import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class TimerAnimationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController _timerAnimationConrtoller;
  late int _maxSeconds = 25 * 60;

  late int _secondsLeft;
  bool _isTimerStarted = false;

  set maxSeconds(int maxSeconds) {
    maxSeconds = maxSeconds;
    _secondsLeft = maxSeconds;
  }

  @override
  void onInit() {
    _timerAnimationConrtoller = AnimationController(
        vsync: this, duration: _maxSeconds.seconds, value: 1.0);
    _timerAnimationConrtoller.addListener(_timerAnimationListener);
    super.onInit();
  }

  set _setSecondsLeft(int value) {
    if (_secondsLeft == value) return;
    _secondsLeft = value;
    update([text_getbuilder]);
  }

  int get secondsLeft => _secondsLeft;
  double get circularLineDeg => _timerAnimationConrtoller.value * 360;
  bool get isTimerStarted => _isTimerStarted;

  void _timerAnimationListener() {
    update([circularLine_getbuilder]);
    _setSecondsLeft = (_maxSeconds * _timerAnimationConrtoller.value).round();
  }

  void start() {
    _isTimerStarted = true;
    _timerAnimationConrtoller.reverse(from: 1.0);
  }

  void pause() {
    _timerAnimationConrtoller.stop();
  }

  void resume() {
    _timerAnimationConrtoller.reverse();
  }

  void stop() async {
    _isTimerStarted = false;
    _timerAnimationConrtoller.animateTo(1.0, duration: 500.milliseconds);
  }
}
