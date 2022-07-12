import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'enum.dart';

class CircleAnimatedButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Alignment> animationLeft;
  late final Animation<Alignment> animationRight;

  CircleAnimatedButtonStatus _circleButtonStatus =
      CircleAnimatedButtonStatus.finished;

  bool _isAnimating = false;

  bool get isAnimating => _isAnimating;
  bool get isStarted =>
      _circleButtonStatus == CircleAnimatedButtonStatus.started;
  bool get isPaused => _circleButtonStatus == CircleAnimatedButtonStatus.pause;
  bool get isResumed =>
      _circleButtonStatus == CircleAnimatedButtonStatus.resumed;
  bool get isFinished =>
      _circleButtonStatus == CircleAnimatedButtonStatus.finished;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animationController.addListener(() => update());

    animationLeft = animationController.drive(
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.centerLeft,
      ),
    );
    animationRight = animationController.drive(
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.centerRight,
      ),
    );
    super.onInit();
  }

  void start() async {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.started;
    await _startAnimations();
  }

  void pause() {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.pause;

    update();
  }

  void resume() {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.resumed;
    update();
  }

  void finish() {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.finished;
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    _isAnimating = true;
    if (isFinished) {
      await animationController.reverse();
    } else {
      await animationController.forward();
    }
    _isAnimating = false;
  }
}
