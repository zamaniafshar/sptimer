export 'pomodoro_timer.dart';
import 'dart:async';
import 'package:android_long_task/android_long_task.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/services/foreground_service/foreground_service_model.dart';

abstract class TimerForegroundService {
  static Future<void> start(PomodoroTimerModel initData) async {
    ForegroundServiceModel data =
        ForegroundServiceModel.fromJson(initData.toMap());
    await AppClient.execute(data);
  }

  static void stop() {}

  static get isStarted => false;
}
