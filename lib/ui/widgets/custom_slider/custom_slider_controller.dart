import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class CustomSliderController extends GetxController with GetSingleTickerProviderStateMixin {
  final Rx<double> _sliderValue = 4.0.obs;
  final Rx<bool> _isActive = true.obs;
  late final AnimationController _animationController;
  late Animation<double> _animation;

  bool get isActive => _isActive.value;
  double get sliderValue => _sliderValue.value;

  @override
  void onInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _animationController.addListener(() {
      _sliderValue.value = _animation.value;
    });
    super.onInit();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void setSliderValue(double newValue) {
    newValue = newValue.roundToDouble();
    if (newValue != sliderValue) {
      _sliderValue.value = newValue;
    }
  }

  void animateTo(double newValue) {
    _animation = Tween(begin: sliderValue, end: newValue).animate(_animationController);
    _animationController.forward(from: 0.0);
  }

  void activate() => _isActive.value = true;
  void deactivate() => _isActive.value = false;
}
