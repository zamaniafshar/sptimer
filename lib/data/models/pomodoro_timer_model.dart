import 'package:pomotimer/util/util.dart';
import 'package:get/get.dart';

class PomodoroTimerModel {
  PomodoroTimerModel({
    required this.maxRound,
    required this.remainingDuration,
    required this.pomodoroRound,
    required this.isRestTime,
  });
  final Duration remainingDuration;
  final int maxRound;
  final int pomodoroRound;
  final bool isRestTime;

  Map<String, Object> toMap() => {
        kRemainingDurationKey: remainingDuration.inSeconds,
        kPomodoroRoundKey: pomodoroRound,
        kMaxRoundKey: maxRound,
        kIsRestTimeKey: isRestTime,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) =>
      PomodoroTimerModel(
        remainingDuration: (data[kRemainingDurationKey] as int).seconds,
        pomodoroRound: data[kPomodoroRoundKey] as int,
        maxRound: data[kMaxRoundKey] as int,
        isRestTime: data[kIsRestTimeKey] as bool,
      );
}
