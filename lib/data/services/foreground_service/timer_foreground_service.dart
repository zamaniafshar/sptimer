import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/services/foreground_service/pomodoro_service.dart';
import 'package:pomotimer/utils/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TimerForegroundService {
  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<bool> get isRunning => _service.isRunning();

  Future<void> init() async {
    FlutterLocalNotificationsPlugin()
      ..cancelAll()
      ..resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    await _service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: (_) {},
        onBackground: (_) => false,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onForegroundServiceStart,
        isForegroundMode: true,
        foregroundServiceNotificationTitle: 'Pomotimer',
        foregroundServiceNotificationContent: 'Ready to start',
      ),
    );
  }

  Future<bool> startService(PomodoroAppSateData initData) async {
    bool isError = false;
    await _service.startService();
    await _service.on('started').first.timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        isError = true;
        return null;
      },
    );
    if (isError) return false;
    _service.invoke('initData', initData.toMap());
    return true;
  }

  Future<PomodoroAppSateData?> stopService() async {
    _service.invoke('getData');
    Map<String, dynamic>? data = await _service.on('sendData').first.timeout(
          const Duration(seconds: 1),
          onTimeout: () => null,
        );
    _service.invoke(kStopServiceKey);
    if (data == null) return null;
    return PomodoroAppSateData.fromMap(data);
  }
}
