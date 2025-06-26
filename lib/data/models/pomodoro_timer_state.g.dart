// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_timer_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PomodoroTimerState _$PomodoroTimerStateFromJson(Map<String, dynamic> json) =>
    _PomodoroTimerState(
      task: Task.fromJson(json['task'] as Map<String, dynamic>),
      timerStatus: $enumDecode(_$TimerStatusEnumMap, json['timer_status']),
      pomodoroStatus:
          $enumDecode(_$PomodoroStatusEnumMap, json['pomodoro_status']),
      pomodoroRound: (json['pomodoro_round'] as num).toInt(),
      elapsedTime:
          Duration(microseconds: (json['elapsed_time'] as num).toInt()),
    );

Map<String, dynamic> _$PomodoroTimerStateToJson(_PomodoroTimerState instance) =>
    <String, dynamic>{
      'task': instance.task.toJson(),
      'timer_status': _$TimerStatusEnumMap[instance.timerStatus]!,
      'pomodoro_status': _$PomodoroStatusEnumMap[instance.pomodoroStatus]!,
      'pomodoro_round': instance.pomodoroRound,
      'elapsed_time': instance.elapsedTime.inMicroseconds,
    };

const _$TimerStatusEnumMap = {
  TimerStatus.started: 'started',
  TimerStatus.paused: 'paused',
  TimerStatus.finished: 'finished',
};

const _$PomodoroStatusEnumMap = {
  PomodoroStatus.work: 'work',
  PomodoroStatus.shortBreak: 'shortBreak',
  PomodoroStatus.longBreak: 'longBreak',
};
