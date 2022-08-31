import 'package:get/get.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/home_screen_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(ThemeManager());
    Get.put(CountdownTimerController());
    Get.put(CustomSliderController());
    Get.put(HomeScreenController());
    Get.put(CircleAnimatedButtonController());
    Get.put(UiController());
    Get.put(TimerForegroundService());
    Get.put(MainController());
  }
}
