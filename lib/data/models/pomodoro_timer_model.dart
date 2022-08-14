import 'package:get/get.dart';

import 'package:pomotimer/util/util.dart';

class PomodoroTimerModel {
  PomodoroTimerModel({
    required this.remainingDuration,
    required this.maxDuration,
    required this.maxRound,
    required this.pomodoroRound,
    required this.isWorkTime,
    required this.isTimerStarted,
  });
  final Duration remainingDuration;
  final Duration maxDuration;
  final int? maxRound;
  final int pomodoroRound;
  final bool isWorkTime;
  final bool isTimerStarted;

  Map<String, dynamic> toMap() => {
        kMaxDurationKey: maxDuration.inSeconds,
        kRemainingDurationKey: remainingDuration.inSeconds,
        kPomodoroRoundKey: pomodoroRound,
        kMaxRoundKey: maxRound,
        kIsWorkTimeKey: isWorkTime,
        kIsTimerStartedKey: isTimerStarted,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) => PomodoroTimerModel(
        maxDuration: (data[kMaxDurationKey] as int).seconds,
        remainingDuration: (data[kRemainingDurationKey] as int).seconds,
        pomodoroRound: data[kPomodoroRoundKey] as int,
        maxRound: data[kMaxRoundKey] as int?,
        isWorkTime: data[kIsWorkTimeKey] as bool,
        isTimerStarted: data[kIsTimerStartedKey] as bool,
      );
}
