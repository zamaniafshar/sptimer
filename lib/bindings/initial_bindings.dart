import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/home/home_screen_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CountdownTimerController());
    Get.put(CustomSliderController());
    Get.put(HomeScreenController());
    Get.put(CircleAnimatedButtonController());
    Get.put(MainController()..initData());
  }
}
