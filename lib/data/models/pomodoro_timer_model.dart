import 'package:pomotimer/util/util.dart';

class PomodoroTimerModel {
  PomodoroTimerModel({
    required this.maxRound,
    required this.secondsLeft,
    required this.round,
    required this.isWorkTime,
  });
  final int maxRound;
  int secondsLeft;
  int round;
  bool isWorkTime;

  Map<String, Object> toMap() => {
        kSecondsLeftKey: secondsLeft,
        kCorrentRoundKey: round,
        kMaxRoundKey: maxRound,
        kIsWorkTimeKey: isWorkTime,
      };

  static PomodoroTimerModel fromMap(Map<String, dynamic> data) =>
      PomodoroTimerModel(
        secondsLeft: data[kSecondsLeftKey] as int,
        round: data[kCorrentRoundKey] as int,
        maxRound: data[kMaxRoundKey] as int,
        isWorkTime: data[kIsWorkTimeKey] as bool,
      );
}
