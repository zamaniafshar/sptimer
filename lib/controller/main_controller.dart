import 'dart:async';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomotimer/data/databases/pomodoro_state_database.dart';
import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:pomotimer/data/timers/pomodoro_task_timer.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';

class MainController {
  MainController() {
    _pomodoroTaskTimer = PomodoroTaskTimer(tasksReportageDatabase: _tasksReportageDataBase);
  }
  String initialRoute = RoutesName.baseScreen;
  final _service = TimerForegroundService();
  final _stateDatabase = PomodoroStateDatabase();
  final _tasksReportageDataBase = Get.put(TasksReportageDatabase());
  late final PomodoroTaskTimer _pomodoroTaskTimer;
  bool _isHiveClosed = false;

  void onPomodoroTaskStart(
    PomodoroTaskModel task, {
    PomodoroTaskReportageModel? taskReportageModel,
    bool isAlreadyStarted = false,
  }) {
    final StartPomodoroTaskScreenController controller;
    if (Get.isRegistered<StartPomodoroTaskScreenController>()) {
      controller = Get.find();
    } else {
      controller = Get.put(StartPomodoroTaskScreenController());
    }
    _pomodoroTaskTimer.init(
      initState: task,
      onRoundFinish: controller.onPomodoroRoundFinish,
      onFinish: controller.onPomodoroTimerFinish,
      intervalTime: const Duration(milliseconds: 16),
      taskReportageModel: taskReportageModel,
    );
    controller.init(_pomodoroTaskTimer, isAlreadyStarted);
  }

  Future<void> init() async {
    if (_isHiveClosed) {
      await Hive.initFlutter();
      _isHiveClosed = false;
    }
    await _tasksReportageDataBase.init();
    await _stateDatabase.init();
    await _service.init();
    PomodoroAppSateData? state = (await _stateDatabase.getState()).fold((l) => null, (r) => r);
    if (state == null && !(await _service.isRunning)) return;

    initialRoute += RoutesName.startPomodoroTaskScreen;
    if (state != null) {
      await _stateDatabase.clear();
    } else {
      state = await _service.stopService();
      if (state == null) return _pomodoroTaskTimer.start();
    }
    onPomodoroTaskStart(
      state.pomodoroTaskModel,
      taskReportageModel: state.pomodoroTaskReportageModel,
      isAlreadyStarted: true,
    );
  }

  Future<void> onAppPaused() async {
    if (!Get.isRegistered<StartPomodoroTaskScreenController>()) return;
    StartPomodoroTaskScreenController controller = Get.find();
    if (!controller.isTimerStarted) return;
    if (controller.isTimerStopped) {
      await _pomodoroTaskTimer.saveTaskReport();
      await _stateDatabase.save(_pomodoroTaskTimer.pomodoroAppSateData);
    } else {
      _isHiveClosed = true;
      final appState = _pomodoroTaskTimer.pomodoroAppSateData;
      _pomodoroTaskTimer.stop();
      await Hive.close();
      await _service.startService(appState);
    }
  }
}
