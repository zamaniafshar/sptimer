import 'package:get/get.dart';
import 'package:pomotimer/controller/home_screen_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/ui/widgets/circle_animated_button/circle_animated_button_controller.dart';
import 'package:pomotimer/ui/widgets/circle_timer/circle_timer_controller.dart';
import 'package:pomotimer/ui/widgets/custom_slider/custom_slider_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CircleTimerController());
    Get.put(CustomSliderController());
    Get.put(HomeScreenController());
    Get.put(CircleAnimatedButtonController());
    Get.put(MainController()..initData());
  }
}
