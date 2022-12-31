import 'dart:async';
import 'package:get/get.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:pomotimer/data/services/android_native_channel.dart';
import 'package:pomotimer/data/timers/pomodoro_task_timer.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';

class MainController {
  final AndroidNativeChannel _androidNativeChannel = AndroidNativeChannel();
  final PomodoroTaskTimer _pomodoroTaskTimer =
      PomodoroTaskTimer(tasksReportageDatabase: Get.find());
  String initialRoute = RoutesName.baseScreen;
  bool _isAppPaused = false;

  Future<void> init() async {
    _isAppPaused = false;
    PomodoroAppSateData? state;

    if (await _androidNativeChannel.isServiceRunning) {
      state = await _androidNativeChannel.stopService();
    } else {
      state = await _androidNativeChannel.getState();
    }
    if (state == null) return;
    initialRoute += RoutesName.startPomodoroTaskScreen;
    onPomodoroTaskStart(
      state.pomodoroTaskModel,
      taskReportageModel: state.pomodoroTaskReportageModel,
      isAlreadyStarted: true,
    );
  }

  Future<void> onAppPaused() async {
    if (_isAppPaused) return;
    _isAppPaused = true;
    if (!Get.isRegistered<StartPomodoroTaskScreenController>()) return;
    StartPomodoroTaskScreenController controller = Get.find();
    if (!controller.isTimerStarted) return;
    if (controller.isTimerStopped) {
      await _pomodoroTaskTimer.saveTaskReport();
      await _androidNativeChannel.saveState(_pomodoroTaskTimer.pomodoroAppSateData);
    } else {
      final appState = _pomodoroTaskTimer.pomodoroAppSateData;
      _pomodoroTaskTimer.stop();
      await _androidNativeChannel.startService(appState);
    }
  }

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
      taskReportageModel: taskReportageModel,
    );
    controller.init(_pomodoroTaskTimer, isAlreadyStarted);
  }
}
