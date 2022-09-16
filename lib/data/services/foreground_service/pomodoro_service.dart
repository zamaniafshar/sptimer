import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pomotimer/data/models/pomodoro_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pomotimer/util/util.dart';

void onForegroundServiceStart(ServiceInstance service) async {
  service.invoke('started');
  Map<String, dynamic>? initData = await service.on('initData').first;

  PomodoroTimer timer = PomodoroTimer(
    initData: PomodoroModel.fromMap(initData!),
  );
  timer.start();
  timer.listen(() {
    updatePomodoroNotification(service, timer.remainingDuration);
  });

  service.on('getData').listen((event) {
    service.invoke('sendData', getData(timer).toMap());
  });

  service.on(kStopServiceKey).listen((event) {
    service.stopSelf();
  });
}

void updatePomodoroNotification(ServiceInstance service, Duration remainingDuration) {
  (service as AndroidServiceInstance).setForegroundNotificationInfo(
    title: 'PomoTimer',
    content: remainingDuration.toString().substring(2, 7),
  );
}

PomodoroModel getData(PomodoroTimer timer) => PomodoroModel(
      maxDuration: timer.maxDuration,
      maxRound: timer.maxRound,
      remainingDuration: timer.remainingDuration,
      pomodoroRound: timer.pomodoroRound,
      isWorkTime: timer.isWorkTime,
    );
