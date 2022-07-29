import 'package:android_long_task/android_long_task.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/bindings/initial_bindings.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/pomo_timer_app.dart';

void main() async {
  InitialBindings().dependencies();
  runApp(const PomoTimerApp());
}

@pragma('vm:entry-point')
serviceMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceClient.setExecutionCallback(onForegroundServiceStart);
}
