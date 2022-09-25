import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomotimer/controller/tasks_controller.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

Future<void> initInitialDependencies() async {
  await Get.put(MainController()).init();
  await Hive.initFlutter();
  Get.put(ThemeManager());
  Get.put(TasksController());
}
