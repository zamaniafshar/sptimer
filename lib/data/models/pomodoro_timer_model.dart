import 'package:pomotimer/util/util.dart';

class PomodoroTimerModel {
  PomodoroTimerModel({
    required this.maxRound,
    required this.remainingSeconds,
    required this.round,
    required this.isRestTime,
  });
  final int maxRound;
  final int remainingSeconds;
  final int round;
  final bool isRestTime;

  Map<String, Object> toMap() => {
        kSecondsLeftKey: remainingSeconds,
        kCurrentRoundKey: round,
        kMaxRoundKey: maxRound,
        kIsRestTimeKey: isRestTime,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) =>
      PomodoroTimerModel(
        remainingSeconds: data[kSecondsLeftKey] as int,
        round: data[kCurrentRoundKey] as int,
        maxRound: data[kMaxRoundKey] as int,
        isRestTime: data[kIsRestTimeKey] as bool,
      );
}
