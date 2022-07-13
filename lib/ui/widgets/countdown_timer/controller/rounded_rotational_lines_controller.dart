import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class RoundedRotationalLinesController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController _rotationalLinesAnimationController;
  late final AnimationController _spaceBetweenLinesAnimationController;

  bool isStarted = false;

  @override
  void onInit() {
    _rotationalLinesAnimationController =
        AnimationController(vsync: this, duration: 3.seconds, value: 0.0)
          ..addListener(_rotationalLinesListener);
    _spaceBetweenLinesAnimationController =
        AnimationController(vsync: this, duration: 500.milliseconds);

    super.onInit();
  }

  double get rotationalLinesDeg =>
      _rotationalLinesAnimationController.value * -360;
  double get spaceBetweenRotationalLines =>
      _spaceBetweenLinesAnimationController.value;

  Future<void> start() async {
    isStarted = true;
    update([clockLines_getbuilder]);
    _rotationalLinesAnimationController.animateTo(1.0,
        duration: 500.milliseconds);
    await _spaceBetweenLinesAnimationController.forward();
  }

  void pause() {
    _rotationalLinesAnimationController.stop();
  }

  void resume() {
    _rotationalLinesAnimationController.forward();
  }

  Future<void> cancel() async {
    _rotationalLinesAnimationController.animateBack(
      0.0,
      duration: 500.milliseconds,
    );
    await _spaceBetweenLinesAnimationController.reverse();
    isStarted = false;
    update([clockLines_getbuilder]);
  }

  void _rotationalLinesListener() {
    update([roundedRotationalLines_getbuilder]);
    _countinueRotationalLinesAnimation();
  }

  void _countinueRotationalLinesAnimation() {
    if (isStarted) {
      _forwardRotationalLinesAnimation();
    } else {
      _reverseRotationalLinesAnimation();
    }
  }

  void _reverseRotationalLinesAnimation() {
    if (_rotationalLinesAnimationController.status ==
        AnimationStatus.dismissed) {
      _rotationalLinesAnimationController.reverse(from: 1.0);
    }
  }

  void _forwardRotationalLinesAnimation() {
    if (_rotationalLinesAnimationController.status ==
        AnimationStatus.completed) {
      _rotationalLinesAnimationController.forward(from: 0.0);
    }
  }
}
