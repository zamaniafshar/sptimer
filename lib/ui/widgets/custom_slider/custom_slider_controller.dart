import 'package:get/get.dart';

class CustomSliderController extends GetxController {
  final Rx<double> _sliderValue = 4.0.obs;
  bool _active = true;

  double get sliderValue => _sliderValue.value;

  set sliderValue(double newValue) {
    newValue = newValue.roundToDouble();
    if (newValue != _sliderValue.value && _active) {
      _sliderValue.value = newValue;
    }
  }

  void activate() => _active = true;

  void deactivate() => _active = false;
}
