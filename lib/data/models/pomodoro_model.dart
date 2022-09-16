import 'package:get/get.dart';

class PomodoroModelFields {
  static const kRemainingDurationKey = 'RemainingDuration';
  static const kPomodoroRoundKey = 'PomodoroRoundKey';
  static const kIsWorkTimeKey = 'kIsWorkTimeKey';
  static const kMaxRoundKey = 'kMaxRoundKey';
  static const kMaxDurationKey = 'kMaxDurationKey';
}

class PomodoroModel {
  PomodoroModel({
    required this.currentRemainingDuration,
    required this.currentMaxDuration,
    required this.maxPomodoroRound,
    required this.pomodoroRound,
    required this.isWorkTime,
  });
  final Duration currentRemainingDuration;
  final Duration currentMaxDuration;
  final int? maxPomodoroRound;
  final int pomodoroRound;
  final bool isWorkTime;

  Map<String, dynamic> toMap() => {
        PomodoroModelFields.kMaxDurationKey: currentMaxDuration.inSeconds,
        PomodoroModelFields.kRemainingDurationKey: currentRemainingDuration.inSeconds,
        PomodoroModelFields.kPomodoroRoundKey: pomodoroRound,
        PomodoroModelFields.kMaxRoundKey: maxPomodoroRound,
        PomodoroModelFields.kIsWorkTimeKey: isWorkTime,
      };

  static PomodoroModel fromMap(Map<String, dynamic> data) => PomodoroModel(
        currentMaxDuration: (data[PomodoroModelFields.kMaxDurationKey] as int).seconds,
        currentRemainingDuration: (data[PomodoroModelFields.kRemainingDurationKey] as int).seconds,
        pomodoroRound: data[PomodoroModelFields.kPomodoroRoundKey] as int,
        maxPomodoroRound: data[PomodoroModelFields.kMaxRoundKey] as int?,
        isWorkTime: data[PomodoroModelFields.kIsWorkTimeKey] as bool,
      );
}
