import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/ui/widgets/circle_timer/constants.dart';

class RoundedRotationalLinesController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController _rotationalLinesAnimationController;
  late final AnimationController _spaceBetweenLinesAnimationController;

  bool isStarted = false;

  @override
  void onInit() {
    _rotationalLinesAnimationController =
        AnimationController(vsync: this, duration: 3.seconds, value: 0.0)
          ..addListener(_rotationalLineLisitener);
    _spaceBetweenLinesAnimationController =
        AnimationController(vsync: this, duration: 500.milliseconds);

    super.onInit();
  }

  double get rotationalLinesDeg =>
      _rotationalLinesAnimationController.value * -360;
  double get spaceBetweenRotationalLinesAnimation =>
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

  Future<void> stop() async {
    _rotationalLinesAnimationController.animateBack(
      0.0,
      duration: 500.milliseconds,
    );
    await _spaceBetweenLinesAnimationController.reverse();
    isStarted = false;
    update([clockLines_getbuilder]);
  }

  void _rotationalLineLisitener() {
    update([roundedRotationalLines_getbuilder]);
    _countinueRoundedRotationalLinesAnimation();
  }

  void _countinueRoundedRotationalLinesAnimation() {
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
