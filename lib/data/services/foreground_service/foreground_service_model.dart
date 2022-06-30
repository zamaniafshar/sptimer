import 'dart:convert';
import 'package:android_long_task/android_long_task.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/util/util.dart';

class ForegroundServiceModel extends PomodoroTimerModel implements ServiceData {
  ForegroundServiceModel({
    required int maxRound,
    required int secondsLeft,
    required int round,
    required bool isWorkTime,
  }) : super(
          maxRound: maxRound,
          secondsLeft: secondsLeft,
          round: round,
          isWorkTime: isWorkTime,
        );

  @override
  String get notificationTitle => 'PomoTimer';

  @override
  String get notificationDescription {
    int minute = secondsLeft.secToMinutes;
    int seconds = secondsLeft.secLeft;
    return '$minute:$seconds $round/$maxRound';
  }

  @override
  String toJson() => jsonEncode(super.toMap());

  static ForegroundServiceModel fromJson(Map<String, dynamic> data) {
    return ForegroundServiceModel(
      secondsLeft: data[kSecondsLeftKey] as int,
      round: data[kCorrentRoundKey] as int,
      maxRound: data[kMaxRoundKey] as int,
      isWorkTime: data[kIsWorkTimeKey] as bool,
    );
  }
}
