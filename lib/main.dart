import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sptimer/sptimer_app.dart';

import 'controller/app_controller.dart';
import 'controller/app_settings_controller.dart';
import 'data/databases/pomodoro_tasks_reportage_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Get.put(AppSettingsController()).init();
  await Get.put(PomodoroTasksReportageDatabase()).init();
  await Get.put(AppController()).init();
  runApp(const SptimerApp());
}
