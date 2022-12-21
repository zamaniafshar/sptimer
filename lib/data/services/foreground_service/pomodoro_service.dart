import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomotimer/data/databases/pomodoro_state_database.dart';
import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/timers/pomodoro_task_timer.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

void onForegroundServiceStart(ServiceInstance service) async {
  bool isTimerInitialized = false;
  service.invoke('started');
  final Map<String, dynamic>? initState = await service.on('initData').first.timeout(
        const Duration(seconds: 1),
        onTimeout: () => null,
      );
  if (initState == null) return service.stopSelf();
  final data = PomodoroAppSateData.fromMap(initState);

  PomodoroTaskTimer timer = PomodoroTaskTimer();

  service.on('getData').listen((event) {
    service.invoke('sendData', (isTimerInitialized ? timer.pomodoroAppSateData : data).toMap());
  });

  service.on(kStopServiceKey).listen((event) {
    if (isTimerInitialized) timer.cancel();
    service.stopSelf();
  });

  timer.init(
    isForegroundService: true,
    initState: data.pomodoroTaskModel,
    onRoundFinish: () async {
      updatePomodoroNotification(service, timer.pomodoroTask);
    },
    onFinish: () async {
      await Hive.initFlutter();
      final stateDataBase = PomodoroStateDatabase();
      await stateDataBase.init();
      await stateDataBase.save(timer.pomodoroAppSateData);
      await Hive.close();
      showTaskCompletedNotification(timer.pomodoroTask);
      service.stopSelf();
    },
  );
  isTimerInitialized = true;
  updatePomodoroNotification(service, timer.pomodoroTask);
  timer.start();
  timer.listen(() {
    updatePomodoroNotification(service, timer.pomodoroTask);
  });
}

void updatePomodoroNotification(ServiceInstance service, PomodoroTaskModel state) {
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: state.title,
    content: state.remainingDuration.toString().substring(2, 7),
  );
}

Future<void> showTaskCompletedNotification(
  PomodoroTaskModel state,
) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notif_pomotimer');

  const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  flutterLocalNotificationsPlugin.show(
    kNotificationId,
    state.title,
    'Completed',
    NotificationDetails(
      android: AndroidNotificationDetails(
        kNotificationChannelId,
        kNotificationChannelName,
        colorized: false,
        importance: Importance.low,
        priority: Priority.low,
        playSound: false,
        enableVibration: true,
        vibrationPattern: Int64List.fromList(kVibrationPattern),
        channelDescription: kNotificationChannelDescription,
        icon: 'notif_pomotimer',
      ),
    ),
  );
}
