import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/util/util.dart';

class TimerForegroundService {
  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<bool> get isStarted => _service.isRunning();

  Future<void> init() async {
    await _service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: (_) {},
        onBackground: (_) => false,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: _onForegroundServiceStart,
        isForegroundMode: true,
      ),
    );
  }

  Future<void> start(PomodoroTimerModel initData) async {
    await _service.startService();
    _service.invoke(kInitDataOrderKey, initData.toMap());
  }

  Future<PomodoroTimerModel> stop() async {
    _service.invoke(kStopServiceOrderKey);
    Map<String, dynamic>? map = await _service.on(kgetDataOrderKey).first;
    return PomodoroTimerModel.fromMap(map!);
  }
}

void _onForegroundServiceStart(ServiceInstance service) async {
  Map<String, dynamic>? map = await service.on(kInitDataOrderKey).first;
  PomodoroTimerModel initData = PomodoroTimerModel.fromMap(map!);
  PomodoroTimer timer = PomodoroTimer(data: initData)..start();

  timer.listenEvery(const Duration(seconds: 1), () {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: 'PomoTimer',
        content: timer.remainingDuration.toString(),
      );
    }
  });

  service.on(kStopServiceOrderKey).listen((event) {
    service.invoke(kgetDataOrderKey);
    service.stopSelf();
  });
}
