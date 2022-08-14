import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/util/util.dart';

void onForegroundServiceStart(ServiceInstance service) async {
  PomodoroTimer timer = PomodoroTimer(onRestartTimer: () async {
    notifyStatusListener(service, kRestartedKey);
    await Future.delayed(const Duration(microseconds: 500));
  }, onFinish: () {
    notifyStatusListener(service, kFinishedKey);
  });

  service.on(kStartTimerKey).listen((event) {
    timer.start(event![kMaxRoundKey]);
    timer.listenEvery(const Duration(seconds: 1), () {
      updateNotification(service, timer.remainingDuration);
    });
  });

  service.on(kGetPomodoroDataKey).listen((event) {
    service.invoke(kSendPomodoroDataKey, getData(timer).toMap());
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

void updateNotification(ServiceInstance service, Duration remainingDuration) {
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: 'PomoTimer',
    content: 'Remaining duration: ${remainingDuration.toString().substring(2, 7)}',
  );
}

void notifyStatusListener(ServiceInstance service, String status) {
  service.invoke(kNotifyStatusListenerKey, {kPomodoroTimerStatusKey: status});
}

PomodoroTimerModel getData(PomodoroTimer timer) => PomodoroTimerModel(
      maxDuration: timer.maxDuration,
      maxRound: timer.maxRound,
      remainingDuration: timer.remainingDuration,
      pomodoroRound: timer.pomodoroRound,
      isWorkTime: timer.isWorkTime,
      isTimerStarted: timer.isStarted,
    );
