import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/models/pomodoro_model.dart';
import 'package:pomotimer/data/services/foreground_service/pomodoro_service.dart';
import 'package:pomotimer/util/util.dart';

class TimerForegroundService {
  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<bool> get isRunning => _service.isRunning();

  Future<void> init() async {
    await _service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: (_) {},
        onBackground: (_) => false,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onForegroundServiceStart,
        isForegroundMode: true,
        foregroundServiceNotificationTitle: 'PomoTimer',
        foregroundServiceNotificationContent: 'Ready to start',
      ),
    );
  }

  Future<void> startService(PomodoroTaskModel initData) async {
    await _service.startService();
    await _service.on('started').first;
    _service.invoke('initData', initData.toMap());
    print(initData.toMap());
  }

  Future<PomodoroTaskModel> stopService() async {
    print('***********************');
    _service.invoke('getData');
    Map<String, dynamic>? data = await _service.on('sendData').first;
    print(data);
    _service.invoke(kStopServiceKey);
    return PomodoroTaskModel.fromMap(data!);
  }
}
