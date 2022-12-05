import 'package:get/get.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/controller/main_controller.dart';

Future<void> initInitialDependencies() async {
  await Get.put(MainController()).init();
  Get.put(ThemeManager());
}
