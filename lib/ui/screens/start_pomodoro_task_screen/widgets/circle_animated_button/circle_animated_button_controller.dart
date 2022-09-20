import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'enum.dart';

class CircleAnimatedButtonController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> animationLeft;
  late final Animation<Alignment> animationRight;

  CircleAnimatedButtonStatus _circleButtonStatus = CircleAnimatedButtonStatus.finished;

  bool _isAnimating = false;

  bool get isAnimating => _isAnimating;
  bool get isStarted => _circleButtonStatus == CircleAnimatedButtonStatus.started;
  bool get isPaused => _circleButtonStatus == CircleAnimatedButtonStatus.pause;
  bool get isResumed => _circleButtonStatus == CircleAnimatedButtonStatus.resumed;
  bool get isFinished => _circleButtonStatus == CircleAnimatedButtonStatus.finished;

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animationController.addListener(() => update());

    animationLeft = _animationController.drive(
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.centerLeft,
      ),
    );
    animationRight = _animationController.drive(
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.centerRight,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  void startAnimation() async {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.started;
    await _startAnimations();
  }

  void pauseAnimation() {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.pause;

    update();
  }

  void resumeAnimation() {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.resumed;
    update();
  }

  void finishAnimation() {
    if (isAnimating) return;
    _circleButtonStatus = CircleAnimatedButtonStatus.finished;
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    _isAnimating = true;
    if (isFinished) {
      await _animationController.reverse();
    } else {
      await _animationController.forward();
    }
    _isAnimating = false;
  }
}
