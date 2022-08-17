import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class CustomSliderController extends GetxController with GetSingleTickerProviderStateMixin {
  final Rx<double> _sliderValue = 4.0.obs;
  final Rx<bool> _isActive = true.obs;
  late final AnimationController _animationController;
  late Animation<double> _animation;
  late double _newValue;
  late CompleteTimer _timer;

  bool get isActive => _isActive.value;
  double get sliderValue => _sliderValue.value;

  @override
  void onInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _animationController.addListener(() {
      _sliderValue.value = _animation.value;
    });
    _timer = CompleteTimer(
      duration: const Duration(milliseconds: 50),
      callback: animate,
      autoStart: false,
    );
    super.onInit();
  }

  void setSliderValue(double newValue) {
    newValue = newValue.roundToDouble();
    if (newValue != sliderValue) {
      _newValue = newValue;
      _timer.cancel();
      _timer.start();
    }
  }

  void animate(_) {
    _animation = Tween(begin: sliderValue, end: _newValue).animate(_animationController);
    _animationController.forward(from: 0.0);
  }

  void activate() => _isActive.value = true;
  void deactivate() => _isActive.value = false;
}
