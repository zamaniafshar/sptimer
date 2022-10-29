import 'package:get/get.dart';

import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/timer_status.dart';
import 'package:pomotimer/data/enum/tones.dart';

class PomodoroTaskModelFields {
  static const kRemainingDuration = 'kCurrentRemainingDurationKey';
  static const kPomodoroRound = 'PomodoroRoundKey';
  static const kPomodoroStatus = 'kPomodoroStatus';
  static const kMaxRound = 'kMaxRoundKey';
  static const kWorkDuration = 'kWorkDurationKey';
  static const kShortBreakDuration = 'kShortBreakDurationKey';
  static const kLongBreakDuration = 'kLongBreakDurationKey';
  static const kTimerStatus = 'kTimerStatus';
  static const kTitle = 'kTitle';
  static const kId = 'kId';
  static const kVibrate = 'kVibrate';
  static const kTone = 'kTone';
  static const kToneVolume = 'kToneVolume';
  static const kStatusVolume = 'kStatusVolume';
  static const kReadStatusAloud = 'kReadStatusAloud';
}

class PomodoroTaskModel {
  PomodoroTaskModel({
    this.remainingDuration,
    this.id,
    this.pomodoroRound = 1,
    this.pomodoroStatus = PomodoroStatus.work,
    this.timerStatus = TimerStatus.cancel,
    required this.title,
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.maxPomodoroRound,
    required this.vibrate,
    required this.tone,
    required this.toneVolume,
    required this.statusVolume,
    required this.readStatusAloud,
  });

  final Duration? remainingDuration;
  final int? id;
  final String title;
  final Duration workDuration;
  final Duration shortBreakDuration;
  final Duration longBreakDuration;
  final int maxPomodoroRound;
  final int pomodoroRound;
  final PomodoroStatus pomodoroStatus;
  final TimerStatus timerStatus;
  final bool vibrate;
  final Tones tone;
  final double toneVolume;
  final double statusVolume;
  final bool readStatusAloud;

  Map<String, dynamic> toMap() => {
        PomodoroTaskModelFields.kRemainingDuration: remainingDuration?.inSeconds,
        PomodoroTaskModelFields.kWorkDuration: workDuration.inSeconds,
        PomodoroTaskModelFields.kShortBreakDuration: shortBreakDuration.inSeconds,
        PomodoroTaskModelFields.kLongBreakDuration: longBreakDuration.inSeconds,
        PomodoroTaskModelFields.kPomodoroRound: pomodoroRound,
        PomodoroTaskModelFields.kMaxRound: maxPomodoroRound,
        PomodoroTaskModelFields.kPomodoroStatus: pomodoroStatus.index,
        PomodoroTaskModelFields.kTimerStatus: timerStatus.index,
        PomodoroTaskModelFields.kTitle: title,
        PomodoroTaskModelFields.kId: id,
        PomodoroTaskModelFields.kVibrate: vibrate,
        PomodoroTaskModelFields.kTone: tone.index,
        PomodoroTaskModelFields.kToneVolume: toneVolume,
        PomodoroTaskModelFields.kStatusVolume: statusVolume,
        PomodoroTaskModelFields.kReadStatusAloud: readStatusAloud,
      };

  static PomodoroTaskModel fromMap(Map<dynamic, dynamic> data) => PomodoroTaskModel(
      remainingDuration: (data[PomodoroTaskModelFields.kRemainingDuration] as int?)?.seconds,
      workDuration: (data[PomodoroTaskModelFields.kWorkDuration] as int).seconds,
      shortBreakDuration: (data[PomodoroTaskModelFields.kShortBreakDuration] as int).seconds,
      longBreakDuration: (data[PomodoroTaskModelFields.kLongBreakDuration] as int).seconds,
      pomodoroRound: data[PomodoroTaskModelFields.kPomodoroRound] as int,
      maxPomodoroRound: data[PomodoroTaskModelFields.kMaxRound]! as int,
      pomodoroStatus: PomodoroStatus.values[data[PomodoroTaskModelFields.kPomodoroStatus] as int],
      timerStatus: TimerStatus.values[data[PomodoroTaskModelFields.kTimerStatus] as int],
      title: data[PomodoroTaskModelFields.kTitle] as String,
      id: data[PomodoroTaskModelFields.kId] as int,
      vibrate: data[PomodoroTaskModelFields.kVibrate] as bool,
      tone: Tones.values[data[PomodoroTaskModelFields.kTone] as int],
      toneVolume: data[PomodoroTaskModelFields.kToneVolume] as double,
      statusVolume: data[PomodoroTaskModelFields.kStatusVolume] as double,
      readStatusAloud: data[PomodoroTaskModelFields.kReadStatusAloud] as bool);

  PomodoroTaskModel copyWith({
    Duration? remainingDuration,
    Duration? currentMaxDuration,
    int? id,
    String? title,
    Duration? workDuration,
    Duration? shortBreakDuration,
    Duration? longBreakDuration,
    int? maxPomodoroRound,
    int? pomodoroRound,
    PomodoroStatus? pomodoroStatus,
    TimerStatus? timerStatus,
    bool? vibrate,
    Tones? tone,
    double? toneVolume,
    double? statusVolume,
    bool? readStatusAloud,
  }) {
    return PomodoroTaskModel(
      remainingDuration: remainingDuration ?? this.remainingDuration,
      id: id ?? this.id,
      title: title ?? this.title,
      workDuration: workDuration ?? this.workDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      maxPomodoroRound: maxPomodoroRound ?? this.maxPomodoroRound,
      pomodoroRound: pomodoroRound ?? this.pomodoroRound,
      pomodoroStatus: pomodoroStatus ?? this.pomodoroStatus,
      timerStatus: timerStatus ?? this.timerStatus,
      vibrate: vibrate ?? this.vibrate,
      tone: tone ?? this.tone,
      toneVolume: toneVolume ?? this.toneVolume,
      statusVolume: statusVolume ?? this.statusVolume,
      readStatusAloud: readStatusAloud ?? this.readStatusAloud,
    );
  }
}
