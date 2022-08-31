import 'package:get/get.dart';

class PomodoroTimerModelFields {
  static const kRemainingDurationKey = 'RemainingDuration';
  static const kPomodoroRoundKey = 'PomodoroRoundKey';
  static const kIsWorkTimeKey = 'kIsWorkTimeKey';
  static const kMaxRoundKey = 'kMaxRoundKey';
  static const kMaxDurationKey = 'kMaxDurationKey';
}

class PomodoroTimerModel {
  PomodoroTimerModel({
    required this.remainingDuration,
    required this.maxDuration,
    required this.maxRound,
    required this.pomodoroRound,
    required this.isWorkTime,
  });
  final Duration remainingDuration;
  final Duration maxDuration;
  final int? maxRound;
  final int pomodoroRound;
  final bool isWorkTime;

  Map<String, dynamic> toMap() => {
        PomodoroTimerModelFields.kMaxDurationKey: maxDuration.inSeconds,
        PomodoroTimerModelFields.kRemainingDurationKey: remainingDuration.inSeconds,
        PomodoroTimerModelFields.kPomodoroRoundKey: pomodoroRound,
        PomodoroTimerModelFields.kMaxRoundKey: maxRound,
        PomodoroTimerModelFields.kIsWorkTimeKey: isWorkTime,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) => PomodoroTimerModel(
        maxDuration: (data[PomodoroTimerModelFields.kMaxDurationKey] as int).seconds,
        remainingDuration: (data[PomodoroTimerModelFields.kRemainingDurationKey] as int).seconds,
        pomodoroRound: data[PomodoroTimerModelFields.kPomodoroRoundKey] as int,
        maxRound: data[PomodoroTimerModelFields.kMaxRoundKey] as int?,
        isWorkTime: data[PomodoroTimerModelFields.kIsWorkTimeKey] as bool,
      );
}
