import 'package:get/get.dart';
import 'package:pomotimer/controller/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/countdown_timer/countdown_timer_controller.dart';
import 'package:pomotimer/ui/widgets/custom_slider/custom_slider_controller.dart';

class UiController {
  final CustomSliderController _sliderController = Get.find();
  final CountdownTimerController _circleTimerController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();

  int get maxRound => _sliderController.sliderValue.toInt();

  void onStart() {
    _circleTimerController.start();
    _homeScreenController.showGradiantColor(true);
    _sliderController.deactivate();
  }

  void onPause() {
    _circleTimerController.pause();
  }

  void onResume() {
    _circleTimerController.resume();
  }

  void onFinish() {
    _circleTimerController.cancel();
    _homeScreenController.showGradiantColor(false);
    _sliderController.activate();
  }

  Future<void> onRestart() async {
    await _circleTimerController.setTimer(5);
  }
}
