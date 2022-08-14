import 'package:get/get.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/util/constants/constants.dart';

class MainController {
  MainController() {
    init();
  }
  final UiController uiController = Get.find();
  final TimerForegroundService service = TimerForegroundService();

  void init() async {
    await service.init();
    uiController.init(await service.data);
    service.listen((data) async {
      if (data![kPomodoroTimerStatusKey] == kRestartedKey) {
        uiController.onPomodoroTimerRestart(await service.data);
      } else {
        uiController.onPomodoroTimerFinish(await service.data);
      }
    });
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

  Future<void> onAppInactive() async {
    if ((await service.data).isTimerStarted) return;
    service.stopService();
  }
}
