import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/database/foreground_service_db.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/ui/screens/home/home_screen_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Hive.initFlutter();
    ForegroundServiceDB foregroundServiceDB = ForegroundServiceDB();
    await foregroundServiceDB.init();
    print(foregroundServiceDB.isForegroundServiceStarted);
    Get.put(foregroundServiceDB);
    Get.put(CountdownTimerController());
    Get.put(CustomSliderController());
    Get.put(HomeScreenController());
    Get.put(CircleAnimatedButtonController());
    Get.put(UiController());
    Get.put(TimerForegroundService());
    Get.put(MainController());
  }
}
