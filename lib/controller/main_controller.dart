import 'package:get/get.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/pomodoro_timer.dart';

class MainController {
  MainController() {
    init();
  }
  final UiController uiController = UiController();

  PomodoroTimer? pomodoroTimer;

  void init() {
    pomodoroTimer = PomodoroTimer(
      maxRound: uiController.maxRound,
      onRestartTimer: () async {
        uiController.setTimer(pomodoroTimer!.maxDuration);
        await uiController.onRestart();
      },
      onFinish: () {
        uiController.setTimer(pomodoroTimer!.maxDuration);
        uiController.onFinish();
      },
    );
    uiController.setTimer(pomodoroTimer!.maxDuration);
  }

  void onStart() {
    pomodoroTimer!.start();
    uiController.onStart();
  }

  void onPause() {
    pomodoroTimer!.stop();
    uiController.onPause();
  }

  void onResume() {
    pomodoroTimer!.start();
    uiController.onResume();
  }

  void onFinish() {
    pomodoroTimer!.cancel();
    uiController.onFinish();
  }

  void sendAppToBackground() {}

  void initData() {}
}
