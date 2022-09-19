import 'package:get/get.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';

class PomodoroTaskModelFields {
  static const kCurrentRemainingDurationKey = 'kCurrentRemainingDurationKey';
  static const kPomodoroRoundKey = 'PomodoroRoundKey';
  static const kPomodoroStatus = 'kPomodoroStatus';
  static const kMaxRoundKey = 'kMaxRoundKey';
  static const kWorkDurationKey = 'kWorkDurationKey';
  static const kShortBreakDurationKey = 'kShortBreakDurationKey';
  static const kLongBreakDurationKey = 'kLongBreakDurationKey';
  static const kTimerStatus = 'kTimerStatus';
  static const kTitle = 'kTitle';
  static const kId = 'kId';
}

class PomodoroTaskModel {
  PomodoroTaskModel({
    this.id,
    required this.title,
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.maxPomodoroRound,
    this.pomodoroRound = 0,
    this.pomodoroStatus = PomodoroStatus.work,
    this.timerStatus = TimerStatus.cancel,
    Duration? currentRemainingDuration,
  }) {
    this.currentRemainingDuration = currentRemainingDuration ?? currentMaxDuration;
  }

  late Duration currentRemainingDuration;
  int? id;
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
        PomodoroTaskModelFields.kCurrentRemainingDurationKey: currentRemainingDuration.inSeconds,
        PomodoroTaskModelFields.kWorkDurationKey: workDuration.inSeconds,
        PomodoroTaskModelFields.kShortBreakDurationKey: shortBreakDuration.inSeconds,
        PomodoroTaskModelFields.kLongBreakDurationKey: longBreakDuration.inSeconds,
        PomodoroTaskModelFields.kPomodoroRoundKey: pomodoroRound,
        PomodoroTaskModelFields.kMaxRoundKey: maxPomodoroRound,
        PomodoroTaskModelFields.kPomodoroStatus: pomodoroStatus.index,
        PomodoroTaskModelFields.kTimerStatus: timerStatus.index,
        PomodoroTaskModelFields.kTitle: title,
        PomodoroTaskModelFields.kId: id,
      };

  static PomodoroTaskModel fromMap(Map<dynamic, dynamic> data) => PomodoroTaskModel(
        currentRemainingDuration:
            (data[PomodoroTaskModelFields.kCurrentRemainingDurationKey] as int).seconds,
        workDuration: (data[PomodoroTaskModelFields.kWorkDurationKey] as int).seconds,
        shortBreakDuration: (data[PomodoroTaskModelFields.kShortBreakDurationKey] as int).seconds,
        longBreakDuration: (data[PomodoroTaskModelFields.kLongBreakDurationKey] as int).seconds,
        pomodoroRound: data[PomodoroTaskModelFields.kPomodoroRoundKey] as int,
        maxPomodoroRound: data[PomodoroTaskModelFields.kMaxRoundKey]! as int,
        pomodoroStatus: PomodoroStatus.values[data[PomodoroTaskModelFields.kPomodoroStatus] as int],
        timerStatus: TimerStatus.values[data[PomodoroTaskModelFields.kTimerStatus] as int],
        title: data[PomodoroTaskModelFields.kTitle] as String,
        id: data[PomodoroTaskModelFields.kId] as int,
      );
}
