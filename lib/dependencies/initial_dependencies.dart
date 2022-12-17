import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomotimer/controller/app_settings_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';

Future<void> initInitialDependencies() async {
  await Hive.initFlutter();
  await Get.put(MainController()).init();
  await Get.put(AppSettingsController()).init();
}
