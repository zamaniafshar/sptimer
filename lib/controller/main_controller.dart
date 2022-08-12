import 'package:get/get.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';

class MainController {
  MainController() {
    init();
  }
  final UiController uiController = Get.find();
  final TimerForegroundService service = TimerForegroundService();

  void init() async {
    PomodoroTimerModel? data;
    if (await service.isStarted) {
      data = await service.stop();
    }
    uiController.init(data);
  }

  void onStart() {}

  void onStop() {}

  void onResume() {}

  void onCancel() {}

  void sendAppToBackground() {
    if (uiController.isStarted) {
      service.start(uiController.data);
      uiController.onPomodoroTimerFinish();
    }
  }
}
