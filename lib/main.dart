import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sptimer/sptimer_app.dart';

import 'controller/app_controller.dart';
import 'logic/app_settings_controller.dart';
import 'data/repositories/tasks_reportage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Get.put(AppSettingsController()).init();
  await Get.put(TasksReportageRepository()).init();
  await Get.put(AppController()).init();
  runApp(const SptimerApp());
}
