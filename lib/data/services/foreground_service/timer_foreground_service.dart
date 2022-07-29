import 'dart:async';
import 'package:android_long_task/android_long_task.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/util/util.dart';

class TimerForegroundService {
  Future<bool> get isStarted async => await AppClient.getData() != null;

  Future<void> start(PomodoroTimerModel initialData) async {
    await AppClient.execute(initialData);
  }

  Future<PomodoroTimerModel> stop() async {
    Map<String, dynamic>? map = await AppClient.getData();
    AppClient.stopService();
    return PomodoroTimerModel.fromMap(map!);
  }
}

Future<void> onForegroundServiceStart(Map<String, dynamic>? initialData) async {
  PomodoroTimerModel data = PomodoroTimerModel.fromMap(initialData!);
  PomodoroTimer timer = PomodoroTimer(data: data)..start();
  timer.listenEvery(Duration(seconds: 1), () {
    ServiceClient.update(timer.data);
  });
}
