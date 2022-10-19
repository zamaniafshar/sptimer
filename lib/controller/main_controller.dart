import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomotimer/data/database/pomodoro_state_database.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';

class MainController {
  late String initialRoute = RoutesName.baseScreen;

  final _service = TimerForegroundService();
  final _stateDatabase = PomodoroStateDatabase();

  Future<void> init() async {
    await _stateDatabase.init();
    await _service.init();
    PomodoroTaskModel? state = (await _stateDatabase.getState()).fold((l) => null, (r) => r);
    if (state == null && !(await _service.isRunning)) return;

    initialRoute += RoutesName.startPomodoroTaskScreen;
    if (state != null) {
      await _stateDatabase.clear();
    } else {
      state = await _service.stopService();
    }
    final controller = Get.put(StartPomodoroTaskScreenController());
    await controller.init(state, true);
  }

  Future<void> onAppPaused() async {
    try {
      StartPomodoroTaskScreenController controller = Get.find();
      if (!controller.isTimerStarted) return;
      if (controller.isTimerStopped) {
        _stateDatabase.save(controller.pomodoroTask);
      } else {
        await _service.startService(controller.pomodoroTask);
      }
      SystemNavigator.pop(animated: false);
    } catch (e) {}
  }
}
