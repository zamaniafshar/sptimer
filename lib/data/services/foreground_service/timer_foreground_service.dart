import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/data/services/foreground_service/pomodoro_service.dart';
import 'package:pomotimer/util/util.dart';

class TimerForegroundService {
  final FlutterBackgroundService _service = FlutterBackgroundService();

  Future<PomodoroTimerModel> get data async {
    _service.invoke(kGetPomodoroDataKey);
    Map<String, dynamic>? data = await _service.on(kSendPomodoroDataKey).first;
    return PomodoroTimerModel.fromMap(data!);
  }

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

  void listen(void Function(Map<String, dynamic>?) listener) {
    _service.on(kNotifyStatusListenerKey).listen(listener);
  }

  void startTimer(int maxRound) {
    _service.invoke(kStartTimerKey, {kMaxRoundKey: maxRound});
  }

  void pauseTimer() {
    _service.invoke(kPauseTimerKey);
  }

  void resumeTimer() {
    _service.invoke(kResumeTimerKey);
  }

  void cancelTimer() {
    _service.invoke(kCancelTimerKey);
  }

  void stopService() {
    _service.invoke(kStopServiceKey);
  }
}
