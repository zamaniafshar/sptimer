import 'package:get/get.dart';
import 'package:pomotimer/data/enum/pomodoro_state.dart';

class PomodoroModelFields {
  static const kRemainingDurationKey = 'RemainingDuration';
  static const kPomodoroRoundKey = 'PomodoroRoundKey';
  static const kPomodoroState = 'kPomodoroState';
  static const kMaxRoundKey = 'kMaxRoundKey';
  static const kMaxDurationKey = 'kMaxDurationKey';
  static const kWorkDurationKey = 'kWorkDurationKey';
  static const kShortBreakDurationKey = 'kShortBreakDurationKey';
  static const kLongBreakDurationKey = 'kLongBreakDurationKey';
}

class PomodoroModel {
  PomodoroModel(
      {required this.currentRemainingDuration,
      required this.currentMaxDuration,
      required this.workDuration,
      required this.shortBreakDuration,
      required this.longBreakDuration,
      required this.maxPomodoroRound,
      required this.pomodoroRound,
      required this.pomodoroState});
  final Duration currentRemainingDuration;
  final Duration currentMaxDuration;
  final Duration workDuration;
  final Duration shortBreakDuration;
  final Duration longBreakDuration;
  final int? maxPomodoroRound;
  final int pomodoroRound;
  final PomodoroState pomodoroState;

  Map<String, dynamic> toMap() => {
        PomodoroModelFields.kMaxDurationKey: currentMaxDuration.inSeconds,
        PomodoroModelFields.kRemainingDurationKey: currentRemainingDuration.inSeconds,
        PomodoroModelFields.kWorkDurationKey: workDuration.inSeconds,
        PomodoroModelFields.kShortBreakDurationKey: shortBreakDuration.inSeconds,
        PomodoroModelFields.kLongBreakDurationKey: longBreakDuration.inSeconds,
        PomodoroModelFields.kPomodoroRoundKey: pomodoroRound,
        PomodoroModelFields.kMaxRoundKey: maxPomodoroRound,
        PomodoroModelFields.kPomodoroState: pomodoroState,
      };

  static PomodoroModel fromMap(Map<String, dynamic> data) => PomodoroModel(
        currentMaxDuration: (data[PomodoroModelFields.kMaxDurationKey] as int).seconds,
        currentRemainingDuration: (data[PomodoroModelFields.kRemainingDurationKey] as int).seconds,
        workDuration: (data[PomodoroModelFields.kWorkDurationKey] as int).seconds,
        shortBreakDuration: (data[PomodoroModelFields.kShortBreakDurationKey] as int).seconds,
        longBreakDuration: (data[PomodoroModelFields.kLongBreakDurationKey] as int).seconds,
        pomodoroRound: data[PomodoroModelFields.kPomodoroRoundKey] as int,
        maxPomodoroRound: data[PomodoroModelFields.kMaxRoundKey] as int?,
        pomodoroState: data[PomodoroModelFields.kPomodoroState] as PomodoroState,
      );
}
