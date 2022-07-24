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
        kSecondsLeftKey: remainingDuration.inSeconds,
        kCurrentRoundKey: pomodoroRound,
        kMaxRoundKey: maxRound,
        kIsRestTimeKey: isRestTime,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) =>
      PomodoroTimerModel(
        remainingDuration: (data[kSecondsLeftKey] as int).seconds,
        pomodoroRound: data[kCurrentRoundKey] as int,
        maxRound: data[kMaxRoundKey] as int,
        isRestTime: data[kIsRestTimeKey] as bool,
      );
}
