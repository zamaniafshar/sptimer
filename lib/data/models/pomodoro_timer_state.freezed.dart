// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PomodoroTimerState {
  Task get task;
  TimerStatus get timerStatus;
  PomodoroStatus get pomodoroStatus;
  int get pomodoroRound;
  Duration get elapsedTime;

  /// Create a copy of PomodoroTimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PomodoroTimerStateCopyWith<PomodoroTimerState> get copyWith =>
      _$PomodoroTimerStateCopyWithImpl<PomodoroTimerState>(
          this as PomodoroTimerState, _$identity);

  /// Serializes this PomodoroTimerState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PomodoroTimerState &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.timerStatus, timerStatus) ||
                other.timerStatus == timerStatus) &&
            (identical(other.pomodoroStatus, pomodoroStatus) ||
                other.pomodoroStatus == pomodoroStatus) &&
            (identical(other.pomodoroRound, pomodoroRound) ||
                other.pomodoroRound == pomodoroRound) &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, task, timerStatus,
      pomodoroStatus, pomodoroRound, elapsedTime);

  @override
  String toString() {
    return 'PomodoroTimerState(task: $task, timerStatus: $timerStatus, pomodoroStatus: $pomodoroStatus, pomodoroRound: $pomodoroRound, elapsedTime: $elapsedTime)';
  }
}

/// @nodoc
abstract mixin class $PomodoroTimerStateCopyWith<$Res> {
  factory $PomodoroTimerStateCopyWith(
          PomodoroTimerState value, $Res Function(PomodoroTimerState) _then) =
      _$PomodoroTimerStateCopyWithImpl;
  @useResult
  $Res call(
      {Task task,
      TimerStatus timerStatus,
      PomodoroStatus pomodoroStatus,
      int pomodoroRound,
      Duration elapsedTime});

  $TaskCopyWith<$Res> get task;
}

/// @nodoc
class _$PomodoroTimerStateCopyWithImpl<$Res>
    implements $PomodoroTimerStateCopyWith<$Res> {
  _$PomodoroTimerStateCopyWithImpl(this._self, this._then);

  final PomodoroTimerState _self;
  final $Res Function(PomodoroTimerState) _then;

  /// Create a copy of PomodoroTimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? timerStatus = null,
    Object? pomodoroStatus = null,
    Object? pomodoroRound = null,
    Object? elapsedTime = null,
  }) {
    return _then(_self.copyWith(
      task: null == task
          ? _self.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
      timerStatus: null == timerStatus
          ? _self.timerStatus
          : timerStatus // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
      pomodoroStatus: null == pomodoroStatus
          ? _self.pomodoroStatus
          : pomodoroStatus // ignore: cast_nullable_to_non_nullable
              as PomodoroStatus,
      pomodoroRound: null == pomodoroRound
          ? _self.pomodoroRound
          : pomodoroRound // ignore: cast_nullable_to_non_nullable
              as int,
      elapsedTime: null == elapsedTime
          ? _self.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }

  /// Create a copy of PomodoroTimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskCopyWith<$Res> get task {
    return $TaskCopyWith<$Res>(_self.task, (value) {
      return _then(_self.copyWith(task: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PomodoroTimerState implements PomodoroTimerState {
  const _PomodoroTimerState(
      {required this.task,
      required this.timerStatus,
      required this.pomodoroStatus,
      required this.pomodoroRound,
      required this.elapsedTime});
  factory _PomodoroTimerState.fromJson(Map<String, dynamic> json) =>
      _$PomodoroTimerStateFromJson(json);

  @override
  final Task task;
  @override
  final TimerStatus timerStatus;
  @override
  final PomodoroStatus pomodoroStatus;
  @override
  final int pomodoroRound;
  @override
  final Duration elapsedTime;

  /// Create a copy of PomodoroTimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PomodoroTimerStateCopyWith<_PomodoroTimerState> get copyWith =>
      __$PomodoroTimerStateCopyWithImpl<_PomodoroTimerState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PomodoroTimerStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PomodoroTimerState &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.timerStatus, timerStatus) ||
                other.timerStatus == timerStatus) &&
            (identical(other.pomodoroStatus, pomodoroStatus) ||
                other.pomodoroStatus == pomodoroStatus) &&
            (identical(other.pomodoroRound, pomodoroRound) ||
                other.pomodoroRound == pomodoroRound) &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, task, timerStatus,
      pomodoroStatus, pomodoroRound, elapsedTime);

  @override
  String toString() {
    return 'PomodoroTimerState(task: $task, timerStatus: $timerStatus, pomodoroStatus: $pomodoroStatus, pomodoroRound: $pomodoroRound, elapsedTime: $elapsedTime)';
  }
}

/// @nodoc
abstract mixin class _$PomodoroTimerStateCopyWith<$Res>
    implements $PomodoroTimerStateCopyWith<$Res> {
  factory _$PomodoroTimerStateCopyWith(
          _PomodoroTimerState value, $Res Function(_PomodoroTimerState) _then) =
      __$PomodoroTimerStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Task task,
      TimerStatus timerStatus,
      PomodoroStatus pomodoroStatus,
      int pomodoroRound,
      Duration elapsedTime});

  @override
  $TaskCopyWith<$Res> get task;
}

/// @nodoc
class __$PomodoroTimerStateCopyWithImpl<$Res>
    implements _$PomodoroTimerStateCopyWith<$Res> {
  __$PomodoroTimerStateCopyWithImpl(this._self, this._then);

  final _PomodoroTimerState _self;
  final $Res Function(_PomodoroTimerState) _then;

  /// Create a copy of PomodoroTimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? task = null,
    Object? timerStatus = null,
    Object? pomodoroStatus = null,
    Object? pomodoroRound = null,
    Object? elapsedTime = null,
  }) {
    return _then(_PomodoroTimerState(
      task: null == task
          ? _self.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
      timerStatus: null == timerStatus
          ? _self.timerStatus
          : timerStatus // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
      pomodoroStatus: null == pomodoroStatus
          ? _self.pomodoroStatus
          : pomodoroStatus // ignore: cast_nullable_to_non_nullable
              as PomodoroStatus,
      pomodoroRound: null == pomodoroRound
          ? _self.pomodoroRound
          : pomodoroRound // ignore: cast_nullable_to_non_nullable
              as int,
      elapsedTime: null == elapsedTime
          ? _self.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }

  /// Create a copy of PomodoroTimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskCopyWith<$Res> get task {
    return $TaskCopyWith<$Res>(_self.task, (value) {
      return _then(_self.copyWith(task: value));
    });
  }
}

// dart format on
