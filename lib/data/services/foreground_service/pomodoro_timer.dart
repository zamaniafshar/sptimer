import 'dart:async';
import 'package:android_long_task/android_long_task.dart';
import 'package:pomotimer/data/services/alarm_manager.dart';
import 'package:pomotimer/data/services/foreground_service/foreground_service_model.dart';
import 'package:pomotimer/util/util.dart';

Future<dynamic> startPomoTimer(Map<String, dynamic> initialData) async {
  ForegroundServiceModel state = ForegroundServiceModel.fromJson(initialData);
  PomodoroTimer(state).start();
}

class PomodoroTimer {
  PomodoroTimer(this.state);
  final ForegroundServiceModel state;
  late Timer timer;

  void start() {
    startTimer();
    timerListener(timer);
  }

  void timerListener(_) async {
    state.secondsLeft--;
    updateNotif();

    if (state.secondsLeft != 0) return;
    state.isWorkTime = !state.isWorkTime;
    AlarmManager.playAlarm(state.isWorkTime);
    initSecondsLeft();
    updateNotif();
    timer.cancel();
    startTimer();

    if (state.isWorkTime) return;
    state.round++;
    if (state.round > state.maxRound) {
      timer.cancel();
      await ServiceClient.endExecution(state);
      await ServiceClient.stopService();
    }
  }

  void updateNotif() async {
    await ServiceClient.update(state);
  }

  void initSecondsLeft() {
    state.secondsLeft =
        state.isWorkTime ? kSecondsOfWorkTime : kSecondsOfRestTime;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), timerListener);
  }
}
