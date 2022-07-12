import 'package:get/get.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/pomodoro_timer.dart';

class MainController {
  final UiController uiController = UiController();

  PomodoroTimer? pomodoroTimer;

  void onStart() {
    pomodoroTimer = PomodoroTimer(
      maxRound: uiController.maxRound,
      onRestartTimer: uiController.onRestart,
      onFinish: uiController.onFinish,
    );
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
