import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
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
  }

  void stop() {
    _service.invoke(kStopOrderKey);
  }
}

void _onForegroundServiceStart(ServiceInstance service) {}
