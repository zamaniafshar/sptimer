import 'package:get/get.dart';
import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/controller/main_controller.dart';

Future<void> initInitialDependencies() async {
  await Get.put(MainController()).init();
  await Get.put(TasksReportageDatabase()).init();
  Get.put(ThemeManager());
}
