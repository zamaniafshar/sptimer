import 'package:complete_timer/complete_timer.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class CustomSliderController extends GetxController with GetSingleTickerProviderStateMixin {
  final Rx<double> _sliderValue = 4.0.obs;
  late final AnimationController _animationController;
  double _a = 0.0;
  bool _active = true;
  late CompleteTimer _timer;
  double get sliderValue => _sliderValue.value + _animationController.value * _a;

  void setSliderValue(double newValue) {
    if (_active) {
      _sliderValue.value = newValue;
      _timer.cancel();
      _timer.start();
    }
  }

  void a(_) {
    _sliderValue.value += _a;
    print('its called');
    _a = sliderValue.round() - sliderValue;
    print(_a);
    _animationController.forward(from: 0.0);
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _animationController.addListener(() {
      _sliderValue.update((val) {});
    });
    _timer = CompleteTimer(duration: const Duration(milliseconds: 250), callback: a);
    super.onInit();
  }

  void activate() => _active = true;
  void deactivate() => _active = false;
}
