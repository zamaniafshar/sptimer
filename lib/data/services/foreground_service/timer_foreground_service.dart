import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/data/services/foreground_service/pomodoro_service.dart';
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
        autoStart: true,
        onStart: onForegroundServiceStart,
        isForegroundMode: true,
        foregroundServiceNotificationTitle: 'PomoTimer',
        foregroundServiceNotificationContent: 'Ready to start',
      ),
    );
  }

  void startTimer(int maxRound) {
    _service.invoke(kStartTimerKey, {kMaxRoundKey: maxRound});
  }

  void stopTimer() {
    _service.invoke(kStopTimerKey);
  }

  void cancelTimer() {
    _service.invoke(kCancelTimerKey);
  }

  void stopService() {
    _service.invoke(kStopServiceOrderKey);
  }
}
