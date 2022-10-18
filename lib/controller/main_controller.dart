import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';

class MainController {
  late String initialRoute = RoutesName.baseScreen;

  final TimerForegroundService _service = TimerForegroundService();

  Future<void> init() async {
    await _service.init();
    if (await _service.isRunning) {
      initialRoute += RoutesName.startPomodoroTaskScreen;
      PomodoroTaskModel state = await _service.stopService();
      final controller = Get.put(StartPomodoroTaskScreenController());
      await controller.init(state, true);
    }
  }

  Future<void> onAppPaused() async {
    try {
      StartPomodoroTaskScreenController controller = Get.find();
      if (!controller.isTimerStarted) return;
      await _service.startService(controller.pomodoroTask);
      SystemNavigator.pop(animated: false);
    } catch (e) {}
  }
}
