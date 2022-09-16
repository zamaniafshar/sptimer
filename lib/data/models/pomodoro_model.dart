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
        PomodoroModelFields.kMaxDurationKey: maxDuration.inSeconds,
        PomodoroModelFields.kRemainingDurationKey: remainingDuration.inSeconds,
        PomodoroModelFields.kPomodoroRoundKey: pomodoroRound,
        PomodoroModelFields.kMaxRoundKey: maxRound,
        PomodoroModelFields.kIsWorkTimeKey: isWorkTime,
      };

  static PomodoroModel fromMap(Map<String, dynamic> data) => PomodoroModel(
        maxDuration: (data[PomodoroModelFields.kMaxDurationKey] as int).seconds,
        remainingDuration: (data[PomodoroModelFields.kRemainingDurationKey] as int).seconds,
        pomodoroRound: data[PomodoroModelFields.kPomodoroRoundKey] as int,
        maxRound: data[PomodoroModelFields.kMaxRoundKey] as int?,
        isWorkTime: data[PomodoroModelFields.kIsWorkTimeKey] as bool,
      );
}
