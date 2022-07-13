import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/home/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

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
    await _circleTimerController.restart(5);
  }
}
