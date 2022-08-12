import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/util/util.dart';

void onForegroundServiceStart(ServiceInstance service) async {
  PomodoroTimer timer = PomodoroTimer();

  service.on(kStartTimerKey).listen((event) {
    timer.start(event![kMaxRoundKey]);
    timer.listenEvery(const Duration(seconds: 1), () {
      updateNotification(service, timer);
    });
  });

  service.on(kPauseTimerKey).listen((event) {
    timer.stop();
  });

  service.on(kResumeTimerKey).listen((event) {
    timer.start();
  });

  service.on(kCancelTimerKey).listen((event) {
    timer.cancel();
  });

  service.on(kStopServiceKey).listen((event) {
    service.stopSelf();
  });
}

void updateNotification(ServiceInstance service, PomodoroTimer timer) {
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: 'PomoTimer',
    content: 'Remaining duration: ${timer.remainingDuration.toString().substring(3, 8)}',
  );
}
