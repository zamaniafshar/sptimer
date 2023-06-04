import 'package:get/get.dart';

import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/enums/tones.dart';

const _kRemainingDuration = 'kCurrentRemainingDurationKey';
const _kPomodoroRound = 'PomodoroRoundKey';
const _kPomodoroStatus = 'kPomodoroStatus';
const _kMaxRound = 'kMaxRoundKey';
const _kWorkDuration = 'kWorkDurationKey';
const _kShortBreakDuration = 'kShortBreakDurationKey';
const _kLongBreakDuration = 'kLongBreakDurationKey';
const _kTimerStatus = 'kTimerStatus';
const _kTitle = 'kTitle';
const _kTaskId = 'kTaskId';
const _kVibrate = 'kVibrate';
const _kTone = 'kTone';
const _kToneVolume = 'kToneVolume';
const _kStatusVolume = 'kStatusVolume';
const _kReadStatusAloud = 'kReadStatusAloud';

class PomodoroTaskModel {
  PomodoroTaskModel({
    this.remainingDuration,
    this.id,
    this.pomodoroRound = 0,
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
        _kRemainingDuration: remainingDuration?.inSeconds,
        _kWorkDuration: workDuration.inSeconds,
        _kShortBreakDuration: shortBreakDuration.inSeconds,
        _kLongBreakDuration: longBreakDuration.inSeconds,
        _kPomodoroRound: pomodoroRound,
        _kMaxRound: maxPomodoroRound,
        _kPomodoroStatus: pomodoroStatus.index,
        _kTimerStatus: timerStatus.index,
        _kTitle: title,
        _kTaskId: id,
        _kVibrate: vibrate,
        _kTone: '${tone.name}.${tone.type}',
        _kToneVolume: toneVolume,
        _kStatusVolume: statusVolume,
        _kReadStatusAloud: readStatusAloud,
      };

  static PomodoroTaskModel fromMap(Map<dynamic, dynamic> data) {
    final tone = Tones.values.firstWhere((element) {
      final toneString = (data[_kTone] as String);
      final formatIndex = toneString.indexOf('.');
      final name = toneString.substring(0, formatIndex);
      return element.name == name;
    });
    return PomodoroTaskModel(
      remainingDuration: (data[_kRemainingDuration] as int?)?.seconds,
      workDuration: (data[_kWorkDuration] as int).seconds,
      shortBreakDuration: (data[_kShortBreakDuration] as int).seconds,
      longBreakDuration: (data[_kLongBreakDuration] as int).seconds,
      pomodoroRound: data[_kPomodoroRound],
      maxPomodoroRound: data[_kMaxRound]!,
      pomodoroStatus: PomodoroStatus.values[data[_kPomodoroStatus]],
      timerStatus: TimerStatus.values[data[_kTimerStatus]],
      title: data[_kTitle],
      id: data[_kTaskId],
      vibrate: data[_kVibrate],
      tone: tone,
      toneVolume: data[_kToneVolume],
      statusVolume: data[_kStatusVolume],
      readStatusAloud: data[_kReadStatusAloud],
    );
  }

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
