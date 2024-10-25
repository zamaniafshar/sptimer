import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../enum.dart';

class CircularRotationalLinesController extends GetxController with GetTickerProviderStateMixin {
  late CountdownTimerStatus _status;
  late bool _isStarted;
  late final AnimationController _rotationalLinesController;
  late final AnimationController _spaceBetweenLinesController;

  bool _reverseAnimation = false;

  bool get isStarted => _isStarted;
  CountdownTimerStatus get status => _status;

  void init(CountdownTimerStatus status) {
    _status = status;
    _isStarted = !status.isCancel;
    if (isStarted) {
      if (status.isStart) {
        _start();
      } else {
        _spaceBetweenLinesController.value = 1.0;
        if (_status.isResume) {
          _resume();
        } else {
          _pause();
        }
      }
    }
  }

  void changeStatus(CountdownTimerStatus status) {
    _status = status;
    if (_status.isStart) {
      _start();
    } else if (_status.isPause) {
      _pause();
    } else if (_status.isResume) {
      _resume();
    } else {
      _cancel();
    }
  }

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

  Future<void> _start() async {
    _isStarted = true;
    update([kClockLines_getbuilder]);
    _rotationalLinesController.value = 0.0;
    _rotationalLinesController.animateTo(1.0, duration: const Duration(milliseconds: 500));
    await _spaceBetweenLinesController.forward(from: 0.0);
  }

  void _pause() {
    _rotationalLinesController.stop();
  }

  void _resume() {
    _rotationalLinesController.forward();
  }

  Future<void> _cancel() async {
    _reverseAnimation = true;
    _rotationalLinesController.animateBack(
      0.0,
      duration: const Duration(milliseconds: 500),
    );
    await _spaceBetweenLinesController.reverse(from: 1.0);
    _reverseAnimation = false;
    _isStarted = false;
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
