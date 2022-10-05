import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class CircularRotationalLinesController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController _rotationalLinesController;
  late final AnimationController _spaceBetweenLinesController;

  bool _isStarted = false;
  bool _reverseAnimation = false;

  bool get isStarted => _isStarted;

  @override
  void onInit() {
    _rotationalLinesController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3), value: 0.0)
          ..addStatusListener((_) => _continueAnimation())
          ..addListener(
            () => update([kCircularRotationalLines_getbuilder]),
          );
    _spaceBetweenLinesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.onInit();
  }

  @override
  void onClose() {
    _spaceBetweenLinesController.dispose();
    _rotationalLinesController.dispose();
    super.onClose();
  }

  double get circularLinesDeg => _rotationalLinesController.value * -360;
  double get spaceBetweenRotationalLines => _spaceBetweenLinesController.value;

  Future<void> start() async {
    _isStarted = true;
    update([kClockLines_getbuilder]);
    _rotationalLinesController.animateTo(1.0, duration: const Duration(milliseconds: 500));
    await _spaceBetweenLinesController.forward();
  }

  void pause() {
    _rotationalLinesController.stop();
  }

  void resume() {
    _rotationalLinesController.forward();
  }

  Future<void> cancel() async {
    _reverseAnimation = true;
    _rotationalLinesController.animateBack(
      0.0,
      duration: const Duration(milliseconds: 500),
    );
    await _spaceBetweenLinesController.reverse();
    _isStarted = false;
    _reverseAnimation = false;
    update([kClockLines_getbuilder, kCircularRotationalLines_getbuilder]);
  }

  Future<void> _continueAnimation() async {
    if (!isStarted) return;
    if (_reverseAnimation) {
      await _reverseRotationalLinesAnimation();
    } else {
      await _forwardRotationalLinesAnimation();
    }
  }

  Future<void> _reverseRotationalLinesAnimation() async {
    if (_rotationalLinesController.status == AnimationStatus.dismissed) {
      await _rotationalLinesController.forward(from: 1.0);
    }
  }

  Future<void> _forwardRotationalLinesAnimation() async {
    if (_rotationalLinesController.status == AnimationStatus.completed) {
      _rotationalLinesController.forward(from: 0.0);
    }
  }
}
