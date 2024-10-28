// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'task.dart';

class TaskMapper extends ClassMapperBase<Task> {
  TaskMapper._();

  static TaskMapper? _instance;
  static TaskMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TaskMapper._());
      TonesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Task';

  static String _$id(Task v) => v.id;
  static const Field<Task, String> _f$id = Field('id', _$id, opt: true);
  static String _$title(Task v) => v.title;
  static const Field<Task, String> _f$title = Field('title', _$title);
  static Duration _$workDuration(Task v) => v.workDuration;
  static const Field<Task, Duration> _f$workDuration =
      Field('workDuration', _$workDuration);
  static Duration _$shortBreakDuration(Task v) => v.shortBreakDuration;
  static const Field<Task, Duration> _f$shortBreakDuration =
      Field('shortBreakDuration', _$shortBreakDuration);
  static Duration _$longBreakDuration(Task v) => v.longBreakDuration;
  static const Field<Task, Duration> _f$longBreakDuration =
      Field('longBreakDuration', _$longBreakDuration);
  static int _$maxPomodoroRound(Task v) => v.maxPomodoroRound;
  static const Field<Task, int> _f$maxPomodoroRound =
      Field('maxPomodoroRound', _$maxPomodoroRound);
  static bool _$vibrate(Task v) => v.vibrate;
  static const Field<Task, bool> _f$vibrate = Field('vibrate', _$vibrate);
  static Tones _$tone(Task v) => v.tone;
  static const Field<Task, Tones> _f$tone = Field('tone', _$tone);
  static double _$toneVolume(Task v) => v.toneVolume;
  static const Field<Task, double> _f$toneVolume =
      Field('toneVolume', _$toneVolume);
  static double _$statusVolume(Task v) => v.statusVolume;
  static const Field<Task, double> _f$statusVolume =
      Field('statusVolume', _$statusVolume);
  static bool _$readStatusAloud(Task v) => v.readStatusAloud;
  static const Field<Task, bool> _f$readStatusAloud =
      Field('readStatusAloud', _$readStatusAloud);

  @override
  final MappableFields<Task> fields = const {
    #id: _f$id,
    #title: _f$title,
    #workDuration: _f$workDuration,
    #shortBreakDuration: _f$shortBreakDuration,
    #longBreakDuration: _f$longBreakDuration,
    #maxPomodoroRound: _f$maxPomodoroRound,
    #vibrate: _f$vibrate,
    #tone: _f$tone,
    #toneVolume: _f$toneVolume,
    #statusVolume: _f$statusVolume,
    #readStatusAloud: _f$readStatusAloud,
  };

  static Task _instantiate(DecodingData data) {
    return Task(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        workDuration: data.dec(_f$workDuration),
        shortBreakDuration: data.dec(_f$shortBreakDuration),
        longBreakDuration: data.dec(_f$longBreakDuration),
        maxPomodoroRound: data.dec(_f$maxPomodoroRound),
        vibrate: data.dec(_f$vibrate),
        tone: data.dec(_f$tone),
        toneVolume: data.dec(_f$toneVolume),
        statusVolume: data.dec(_f$statusVolume),
        readStatusAloud: data.dec(_f$readStatusAloud));
  }

  @override
  final Function instantiate = _instantiate;

  static Task fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Task>(map);
  }

  static Task fromJson(String json) {
    return ensureInitialized().decodeJson<Task>(json);
  }
}

mixin TaskMappable {
  String toJson() {
    return TaskMapper.ensureInitialized().encodeJson<Task>(this as Task);
  }

  Map<String, dynamic> toMap() {
    return TaskMapper.ensureInitialized().encodeMap<Task>(this as Task);
  }

  TaskCopyWith<Task, Task, Task> get copyWith =>
      _TaskCopyWithImpl(this as Task, $identity, $identity);
  @override
  String toString() {
    return TaskMapper.ensureInitialized().stringifyValue(this as Task);
  }

  @override
  bool operator ==(Object other) {
    return TaskMapper.ensureInitialized().equalsValue(this as Task, other);
  }

  @override
  int get hashCode {
    return TaskMapper.ensureInitialized().hashValue(this as Task);
  }
}

extension TaskValueCopy<$R, $Out> on ObjectCopyWith<$R, Task, $Out> {
  TaskCopyWith<$R, Task, $Out> get $asTask =>
      $base.as((v, t, t2) => _TaskCopyWithImpl(v, t, t2));
}

abstract class TaskCopyWith<$R, $In extends Task, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? title,
      Duration? workDuration,
      Duration? shortBreakDuration,
      Duration? longBreakDuration,
      int? maxPomodoroRound,
      bool? vibrate,
      Tones? tone,
      double? toneVolume,
      double? statusVolume,
      bool? readStatusAloud});
  TaskCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TaskCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Task, $Out>
    implements TaskCopyWith<$R, Task, $Out> {
  _TaskCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Task> $mapper = TaskMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? title,
          Duration? workDuration,
          Duration? shortBreakDuration,
          Duration? longBreakDuration,
          int? maxPomodoroRound,
          bool? vibrate,
          Tones? tone,
          double? toneVolume,
          double? statusVolume,
          bool? readStatusAloud}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (title != null) #title: title,
        if (workDuration != null) #workDuration: workDuration,
        if (shortBreakDuration != null) #shortBreakDuration: shortBreakDuration,
        if (longBreakDuration != null) #longBreakDuration: longBreakDuration,
        if (maxPomodoroRound != null) #maxPomodoroRound: maxPomodoroRound,
        if (vibrate != null) #vibrate: vibrate,
        if (tone != null) #tone: tone,
        if (toneVolume != null) #toneVolume: toneVolume,
        if (statusVolume != null) #statusVolume: statusVolume,
        if (readStatusAloud != null) #readStatusAloud: readStatusAloud
      }));
  @override
  Task $make(CopyWithData data) => Task(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      workDuration: data.get(#workDuration, or: $value.workDuration),
      shortBreakDuration:
          data.get(#shortBreakDuration, or: $value.shortBreakDuration),
      longBreakDuration:
          data.get(#longBreakDuration, or: $value.longBreakDuration),
      maxPomodoroRound:
          data.get(#maxPomodoroRound, or: $value.maxPomodoroRound),
      vibrate: data.get(#vibrate, or: $value.vibrate),
      tone: data.get(#tone, or: $value.tone),
      toneVolume: data.get(#toneVolume, or: $value.toneVolume),
      statusVolume: data.get(#statusVolume, or: $value.statusVolume),
      readStatusAloud: data.get(#readStatusAloud, or: $value.readStatusAloud));

  @override
  TaskCopyWith<$R2, Task, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TaskCopyWithImpl($value, $cast, t);
}
