// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TasksState {
  bool get isLoading;
  List<Task> get tasks;
  List<Task> get remainingTasks;
  List<Task> get completedTasks;

  /// Create a copy of TasksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TasksStateCopyWith<TasksState> get copyWith =>
      _$TasksStateCopyWithImpl<TasksState>(this as TasksState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TasksState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.tasks, tasks) &&
            const DeepCollectionEquality()
                .equals(other.remainingTasks, remainingTasks) &&
            const DeepCollectionEquality()
                .equals(other.completedTasks, completedTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(tasks),
      const DeepCollectionEquality().hash(remainingTasks),
      const DeepCollectionEquality().hash(completedTasks));

  @override
  String toString() {
    return 'TasksState(isLoading: $isLoading, tasks: $tasks, remainingTasks: $remainingTasks, completedTasks: $completedTasks)';
  }
}

/// @nodoc
abstract mixin class $TasksStateCopyWith<$Res> {
  factory $TasksStateCopyWith(
          TasksState value, $Res Function(TasksState) _then) =
      _$TasksStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      List<Task> tasks,
      List<Task> remainingTasks,
      List<Task> completedTasks});
}

/// @nodoc
class _$TasksStateCopyWithImpl<$Res> implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._self, this._then);

  final TasksState _self;
  final $Res Function(TasksState) _then;

  /// Create a copy of TasksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? tasks = null,
    Object? remainingTasks = null,
    Object? completedTasks = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: null == tasks
          ? _self.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      remainingTasks: null == remainingTasks
          ? _self.remainingTasks
          : remainingTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      completedTasks: null == completedTasks
          ? _self.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _TasksState extends TasksState {
  const _TasksState(
      {required this.isLoading,
      required final List<Task> tasks,
      required final List<Task> remainingTasks,
      required final List<Task> completedTasks})
      : _tasks = tasks,
        _remainingTasks = remainingTasks,
        _completedTasks = completedTasks,
        super._();

  @override
  final bool isLoading;
  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<Task> _remainingTasks;
  @override
  List<Task> get remainingTasks {
    if (_remainingTasks is EqualUnmodifiableListView) return _remainingTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remainingTasks);
  }

  final List<Task> _completedTasks;
  @override
  List<Task> get completedTasks {
    if (_completedTasks is EqualUnmodifiableListView) return _completedTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedTasks);
  }

  /// Create a copy of TasksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TasksStateCopyWith<_TasksState> get copyWith =>
      __$TasksStateCopyWithImpl<_TasksState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TasksState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._remainingTasks, _remainingTasks) &&
            const DeepCollectionEquality()
                .equals(other._completedTasks, _completedTasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_remainingTasks),
      const DeepCollectionEquality().hash(_completedTasks));

  @override
  String toString() {
    return 'TasksState(isLoading: $isLoading, tasks: $tasks, remainingTasks: $remainingTasks, completedTasks: $completedTasks)';
  }
}

/// @nodoc
abstract mixin class _$TasksStateCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$TasksStateCopyWith(
          _TasksState value, $Res Function(_TasksState) _then) =
      __$TasksStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<Task> tasks,
      List<Task> remainingTasks,
      List<Task> completedTasks});
}

/// @nodoc
class __$TasksStateCopyWithImpl<$Res> implements _$TasksStateCopyWith<$Res> {
  __$TasksStateCopyWithImpl(this._self, this._then);

  final _TasksState _self;
  final $Res Function(_TasksState) _then;

  /// Create a copy of TasksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? tasks = null,
    Object? remainingTasks = null,
    Object? completedTasks = null,
  }) {
    return _then(_TasksState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: null == tasks
          ? _self._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      remainingTasks: null == remainingTasks
          ? _self._remainingTasks
          : remainingTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      completedTasks: null == completedTasks
          ? _self._completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

// dart format on
