import 'package:get/get.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';

class PomodoroModelFields {
  static const kCurrentRemainingDurationKey = 'kCurrentRemainingDurationKey';
  static const kPomodoroRoundKey = 'PomodoroRoundKey';
  static const kPomodoroStatus = 'kPomodoroStatus';
  static const kMaxRoundKey = 'kMaxRoundKey';
  static const kWorkDurationKey = 'kWorkDurationKey';
  static const kShortBreakDurationKey = 'kShortBreakDurationKey';
  static const kLongBreakDurationKey = 'kLongBreakDurationKey';
  static const kTimerStatus = 'kTimerStatus';
  static const kTitle = 'kTitle';
}

class PomodoroModel {
  PomodoroModel({
    required this.title,
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.maxPomodoroRound,
    this.pomodoroRound = 1,
    this.pomodoroStatus = PomodoroStatus.work,
    this.timerStatus = TimerStatus.cancel,
    Duration? currentRemainingDuration,
  }) {
    this.currentRemainingDuration = currentRemainingDuration ?? currentMaxDuration;
  }

  late Duration currentRemainingDuration;
  String title;
  Duration workDuration;
  Duration shortBreakDuration;
  Duration longBreakDuration;
  int maxPomodoroRound;
  int pomodoroRound;
  PomodoroStatus pomodoroStatus;
  TimerStatus timerStatus;

  Duration get currentMaxDuration {
    if (pomodoroStatus.isWorkTime) {
      return workDuration;
    } else if (pomodoroStatus.isShortBreakTime) {
      return shortBreakDuration;
    } else {
      return longBreakDuration;
    }
  }

  Map<String, dynamic> toMap() => {
        PomodoroModelFields.kCurrentRemainingDurationKey: currentRemainingDuration.inSeconds,
        PomodoroModelFields.kWorkDurationKey: workDuration.inSeconds,
        PomodoroModelFields.kShortBreakDurationKey: shortBreakDuration.inSeconds,
        PomodoroModelFields.kLongBreakDurationKey: longBreakDuration.inSeconds,
        PomodoroModelFields.kPomodoroRoundKey: pomodoroRound,
        PomodoroModelFields.kMaxRoundKey: maxPomodoroRound,
        PomodoroModelFields.kPomodoroStatus: pomodoroStatus,
        PomodoroModelFields.kTimerStatus: timerStatus,
        PomodoroModelFields.kTitle: title,
      };

  static PomodoroModel fromMap(Map<String, dynamic> data) => PomodoroModel(
        currentRemainingDuration:
            (data[PomodoroModelFields.kCurrentRemainingDurationKey] as int).seconds,
        workDuration: (data[PomodoroModelFields.kWorkDurationKey] as int).seconds,
        shortBreakDuration: (data[PomodoroModelFields.kShortBreakDurationKey] as int).seconds,
        longBreakDuration: (data[PomodoroModelFields.kLongBreakDurationKey] as int).seconds,
        pomodoroRound: data[PomodoroModelFields.kPomodoroRoundKey] as int,
        maxPomodoroRound: data[PomodoroModelFields.kMaxRoundKey]! as int,
        pomodoroStatus: data[PomodoroModelFields.kPomodoroStatus] as PomodoroStatus,
        timerStatus: data[PomodoroModelFields.kTimerStatus] as TimerStatus,
        title: data[PomodoroModelFields.kTitle] as String,
      );
}
