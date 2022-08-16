import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class CustomSliderController extends GetxController with GetSingleTickerProviderStateMixin {
  final Rx<double> _sliderValue = 4.0.obs;
  late final AnimationController _animationController;
  bool _active = true;

  double get sliderValue => _sliderValue.value;

  void setSliderValue(double newValue) {
    newValue = newValue.roundToDouble();
    if (_active) {
      _sliderValue.value = newValue;
    }
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    super.onInit();
  }

  void activate() => _active = true;
  void deactivate() => _active = false;
}
