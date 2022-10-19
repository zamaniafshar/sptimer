import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomotimer/controller/tasks_controller.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/controller/main_controller.dart';

Future<void> initInitialDependencies() async {
  await Hive.initFlutter();
  await Get.put(MainController()).init();
  Get.put(ThemeManager());
  Get.put(TasksController());
}
