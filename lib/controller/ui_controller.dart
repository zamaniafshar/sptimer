import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/home/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

class UiController {
  final CustomSliderController _sliderController = Get.find();
  final CountdownTimerController _countdownTimerController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();

  int get maxRound => _sliderController.sliderValue.toInt();

  void setTimer(Duration maxDuration) {
    _countdownTimerController.setTimer(maxDuration);
  }

  void onStart() {
    _countdownTimerController.start();
    _homeScreenController.showGradiantColor(true);
    _sliderController.deactivate();
  }

  void onPause() {
    _countdownTimerController.pause();
  }

  void onResume() {
    _countdownTimerController.resume();
  }

  void onFinish() {
    _countdownTimerController.cancel();
    _homeScreenController.showGradiantColor(false);
    _sliderController.activate();
  }

  Future<void> onRestart() async {
    await _countdownTimerController.restart();
  }
}
