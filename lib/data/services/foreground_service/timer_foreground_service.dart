import 'dart:async';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';

abstract class TimerForegroundService {
  static Future<void> start(var initData) async {}

  static void stop() {}

  static get isStarted => false;
}
