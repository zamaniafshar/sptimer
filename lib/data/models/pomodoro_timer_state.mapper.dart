// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pomodoro_timer_state.dart';

class PomodoroTimerStateMapper extends ClassMapperBase<PomodoroTimerState> {
  PomodoroTimerStateMapper._();

  static PomodoroTimerStateMapper? _instance;
  static PomodoroTimerStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PomodoroTimerStateMapper._());
      TaskMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PomodoroTimerState';

  static Task _$task(PomodoroTimerState v) => v.task;
  static const Field<PomodoroTimerState, Task> _f$task = Field('task', _$task);
  static TimerStatus _$timerStatus(PomodoroTimerState v) => v.timerStatus;
  static const Field<PomodoroTimerState, TimerStatus> _f$timerStatus =
      Field('timerStatus', _$timerStatus);
  static PomodoroStatus _$pomodoroStatus(PomodoroTimerState v) =>
      v.pomodoroStatus;
  static const Field<PomodoroTimerState, PomodoroStatus> _f$pomodoroStatus =
      Field('pomodoroStatus', _$pomodoroStatus);
  static int _$pomodoroRound(PomodoroTimerState v) => v.pomodoroRound;
  static const Field<PomodoroTimerState, int> _f$pomodoroRound =
      Field('pomodoroRound', _$pomodoroRound);
  static Duration _$elapsedTime(PomodoroTimerState v) => v.elapsedTime;
  static const Field<PomodoroTimerState, Duration> _f$elapsedTime =
      Field('elapsedTime', _$elapsedTime);

  @override
  final MappableFields<PomodoroTimerState> fields = const {
    #task: _f$task,
    #timerStatus: _f$timerStatus,
    #pomodoroStatus: _f$pomodoroStatus,
    #pomodoroRound: _f$pomodoroRound,
    #elapsedTime: _f$elapsedTime,
  };

  static PomodoroTimerState _instantiate(DecodingData data) {
    return PomodoroTimerState(
        task: data.dec(_f$task),
        timerStatus: data.dec(_f$timerStatus),
        pomodoroStatus: data.dec(_f$pomodoroStatus),
        pomodoroRound: data.dec(_f$pomodoroRound),
        elapsedTime: data.dec(_f$elapsedTime));
  }

  @override
  final Function instantiate = _instantiate;

  static PomodoroTimerState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PomodoroTimerState>(map);
  }

  static PomodoroTimerState fromJson(String json) {
    return ensureInitialized().decodeJson<PomodoroTimerState>(json);
  }
}

mixin PomodoroTimerStateMappable {
  String toJson() {
    return PomodoroTimerStateMapper.ensureInitialized()
        .encodeJson<PomodoroTimerState>(this as PomodoroTimerState);
  }

  Map<String, dynamic> toMap() {
    return PomodoroTimerStateMapper.ensureInitialized()
        .encodeMap<PomodoroTimerState>(this as PomodoroTimerState);
  }

  PomodoroTimerStateCopyWith<PomodoroTimerState, PomodoroTimerState,
          PomodoroTimerState>
      get copyWith => _PomodoroTimerStateCopyWithImpl(
          this as PomodoroTimerState, $identity, $identity);
  @override
  String toString() {
    return PomodoroTimerStateMapper.ensureInitialized()
        .stringifyValue(this as PomodoroTimerState);
  }

  @override
  bool operator ==(Object other) {
    return PomodoroTimerStateMapper.ensureInitialized()
        .equalsValue(this as PomodoroTimerState, other);
  }

  @override
  int get hashCode {
    return PomodoroTimerStateMapper.ensureInitialized()
        .hashValue(this as PomodoroTimerState);
  }
}

extension PomodoroTimerStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PomodoroTimerState, $Out> {
  PomodoroTimerStateCopyWith<$R, PomodoroTimerState, $Out>
      get $asPomodoroTimerState =>
          $base.as((v, t, t2) => _PomodoroTimerStateCopyWithImpl(v, t, t2));
}

abstract class PomodoroTimerStateCopyWith<$R, $In extends PomodoroTimerState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  TaskCopyWith<$R, Task, Task> get task;
  $R call(
      {Task? task,
      TimerStatus? timerStatus,
      PomodoroStatus? pomodoroStatus,
      int? pomodoroRound,
      Duration? elapsedTime});
  PomodoroTimerStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PomodoroTimerStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PomodoroTimerState, $Out>
    implements PomodoroTimerStateCopyWith<$R, PomodoroTimerState, $Out> {
  _PomodoroTimerStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PomodoroTimerState> $mapper =
      PomodoroTimerStateMapper.ensureInitialized();
  @override
  TaskCopyWith<$R, Task, Task> get task =>
      $value.task.copyWith.$chain((v) => call(task: v));
  @override
  $R call(
          {Task? task,
          TimerStatus? timerStatus,
          PomodoroStatus? pomodoroStatus,
          int? pomodoroRound,
          Duration? elapsedTime}) =>
      $apply(FieldCopyWithData({
        if (task != null) #task: task,
        if (timerStatus != null) #timerStatus: timerStatus,
        if (pomodoroStatus != null) #pomodoroStatus: pomodoroStatus,
        if (pomodoroRound != null) #pomodoroRound: pomodoroRound,
        if (elapsedTime != null) #elapsedTime: elapsedTime
      }));
  @override
  PomodoroTimerState $make(CopyWithData data) => PomodoroTimerState(
      task: data.get(#task, or: $value.task),
      timerStatus: data.get(#timerStatus, or: $value.timerStatus),
      pomodoroStatus: data.get(#pomodoroStatus, or: $value.pomodoroStatus),
      pomodoroRound: data.get(#pomodoroRound, or: $value.pomodoroRound),
      elapsedTime: data.get(#elapsedTime, or: $value.elapsedTime));

  @override
  PomodoroTimerStateCopyWith<$R2, PomodoroTimerState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PomodoroTimerStateCopyWithImpl($value, $cast, t);
}
