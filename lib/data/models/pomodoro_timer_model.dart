import 'package:pomotimer/util/util.dart';

class PomodoroTimerModel {
  PomodoroTimerModel({
    required this.maxRound,
    required this.remainingSeconds,
    required this.pomodoroRound,
    required this.isRestTime,
  });
  final int maxRound;
  final int remainingSeconds;
  final int pomodoroRound;
  final bool isRestTime;

  Map<String, Object> toMap() => {
        kSecondsLeftKey: remainingSeconds,
        kCurrentRoundKey: pomodoroRound,
        kMaxRoundKey: maxRound,
        kIsRestTimeKey: isRestTime,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) =>
      PomodoroTimerModel(
        remainingSeconds: data[kSecondsLeftKey] as int,
        pomodoroRound: data[kCurrentRoundKey] as int,
        maxRound: data[kMaxRoundKey] as int,
        isRestTime: data[kIsRestTimeKey] as bool,
      );
}
