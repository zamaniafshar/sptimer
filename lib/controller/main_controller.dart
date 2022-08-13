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
    uiController.init(await service.isStarted, await service.data);
  }

  void onStart() {
    service.startTimer(uiController.maxRound);
    uiController.onStart();
  }

  void onPause() {
    service.pauseTimer();
    uiController.onPause();
  }

  void onResume() {
    service.resumeTimer();
    uiController.onResume();
  }

  void onCancel() {
    service.cancelTimer();
    uiController.onCancel();
  }

  void onAppResume() {
    service.stopService();
  }
}
