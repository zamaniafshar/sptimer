import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/widgets/circle_start_button/enum.dart';

class CircleStartButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Alignment> animationLeft;
  late final Animation<Alignment> animationRight;

  final StreamController<CircleButtonStatus> _statusListener =
      StreamController();

  CircleButtonStatus _circleButtonStatus = CircleButtonStatus.finished;
  bool _isAnimationComplete = true;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    animationController.addListener(() {
      update();
    });

    animationLeft = animationController.drive(AlignmentTween(
      begin: Alignment.center,
      end: Alignment.centerLeft,
    ));
    animationRight = animationController.drive(AlignmentTween(
      begin: Alignment.center,
      end: Alignment.centerRight,
    ));
    super.onInit();
  }

  bool get isAnimationComplete => _isAnimationComplete;
  bool get isStarted => _circleButtonStatus == CircleButtonStatus.started;
  bool get isPaused => _circleButtonStatus == CircleButtonStatus.puased;
  bool get isResumed => _circleButtonStatus == CircleButtonStatus.resumed;
  bool get isFinished => _circleButtonStatus == CircleButtonStatus.finished;
  Stream<CircleButtonStatus> get statusListener => _statusListener.stream;

  void start() async {
    if (!_isAnimationComplete) return;
    _circleButtonStatus = CircleButtonStatus.started;
    await _startAnimations();
    _statusListener.add(CircleButtonStatus.started);
  }

  void pause() {
    if (!_isAnimationComplete) return;
    _circleButtonStatus = CircleButtonStatus.puased;
    _statusListener.add(CircleButtonStatus.puased);
    update();
  }

  void resume() {
    if (!_isAnimationComplete) return;
    _circleButtonStatus = CircleButtonStatus.resumed;
    _statusListener.add(CircleButtonStatus.resumed);
    update();
  }

  void finish() async {
    if (!_isAnimationComplete) return;
    _circleButtonStatus = CircleButtonStatus.finished;
    _startAnimations();
    _statusListener.add(CircleButtonStatus.finished);
  }

  Future<void> _startAnimations() async {
    _isAnimationComplete = false;
    if (isFinished) {
      await animationController.reverse();
    } else {
      await animationController.forward();
    }
    _isAnimationComplete = true;
  }
}
