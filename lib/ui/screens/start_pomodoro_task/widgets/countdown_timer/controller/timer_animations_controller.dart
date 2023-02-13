import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class TimerAnimationsController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late double _circularLineDeg;
  late Duration _maxDuration;
  late Duration _remainingDuration;
  late Duration _timerDuration;
  bool _animateBack = false;

  Duration get remainingDuration => _remainingDuration;
  double get circularLineDeg => _circularLineDeg;
  bool get animateBack => _animateBack;
  double get animationValue => _timerDuration.inMilliseconds / _maxDuration.inMilliseconds;

  set maxDuration(Duration value) {
    _maxDuration = value;
  }

  set _setRemainingDuration(Duration value) {
    if (_remainingDuration.inSeconds == value.inSeconds) return;
    _remainingDuration = value;
    update([kCountdownText_getbuilder]);
  }

  void init({
    required Duration maxDuration,
    required Duration timerDuration,
  }) {
    _maxDuration = maxDuration;
    _remainingDuration = timerDuration;
    _timerDuration = timerDuration;
    _circularLineDeg = animationValue * 360;
    update([kCountdownText_getbuilder, kCircularLine_getbuilder]);
  }

  void setTimerDuration(Duration value) {
    _setRemainingDuration = value;
    _timerDuration = value;
    _circularLineDeg = animationValue * 360;
    update([kCircularLine_getbuilder]);
  }

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.addListener(_timerAnimationListener);
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  void _timerAnimationListener() {
    _setRemainingDuration = _maxDuration * _animationController.value;
    _circularLineDeg = _animationController.value * 360;
    update([kCircularLine_getbuilder, kCountdownText_getbuilder]);
  }

  Future<void> restart() async {
    _animateBack = true;
    _animationController.value = animationValue;
    await _animationController.animateTo(1.0, duration: const Duration(milliseconds: 500));
    _animateBack = false;
  }
}
