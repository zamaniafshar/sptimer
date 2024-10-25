// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pomodoro_task.dart';

class PomodoroTaskMapper extends ClassMapperBase<PomodoroTask> {
  PomodoroTaskMapper._();

  static PomodoroTaskMapper? _instance;
  static PomodoroTaskMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PomodoroTaskMapper._());
      TonesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PomodoroTask';

  static String _$id(PomodoroTask v) => v.id;
  static const Field<PomodoroTask, String> _f$id = Field('id', _$id, opt: true);
  static String _$title(PomodoroTask v) => v.title;
  static const Field<PomodoroTask, String> _f$title = Field('title', _$title);
  static Duration _$workDuration(PomodoroTask v) => v.workDuration;
  static const Field<PomodoroTask, Duration> _f$workDuration =
      Field('workDuration', _$workDuration);
  static Duration _$shortBreakDuration(PomodoroTask v) => v.shortBreakDuration;
  static const Field<PomodoroTask, Duration> _f$shortBreakDuration =
      Field('shortBreakDuration', _$shortBreakDuration);
  static Duration _$longBreakDuration(PomodoroTask v) => v.longBreakDuration;
  static const Field<PomodoroTask, Duration> _f$longBreakDuration =
      Field('longBreakDuration', _$longBreakDuration);
  static int _$maxPomodoroRound(PomodoroTask v) => v.maxPomodoroRound;
  static const Field<PomodoroTask, int> _f$maxPomodoroRound =
      Field('maxPomodoroRound', _$maxPomodoroRound);
  static bool _$vibrate(PomodoroTask v) => v.vibrate;
  static const Field<PomodoroTask, bool> _f$vibrate =
      Field('vibrate', _$vibrate);
  static Tones _$tone(PomodoroTask v) => v.tone;
  static const Field<PomodoroTask, Tones> _f$tone = Field('tone', _$tone);
  static double _$toneVolume(PomodoroTask v) => v.toneVolume;
  static const Field<PomodoroTask, double> _f$toneVolume =
      Field('toneVolume', _$toneVolume);
  static double _$statusVolume(PomodoroTask v) => v.statusVolume;
  static const Field<PomodoroTask, double> _f$statusVolume =
      Field('statusVolume', _$statusVolume);
  static bool _$readStatusAloud(PomodoroTask v) => v.readStatusAloud;
  static const Field<PomodoroTask, bool> _f$readStatusAloud =
      Field('readStatusAloud', _$readStatusAloud);

  @override
  final MappableFields<PomodoroTask> fields = const {
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

  static PomodoroTask _instantiate(DecodingData data) {
    return PomodoroTask(
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

  static PomodoroTask fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PomodoroTask>(map);
  }

  static PomodoroTask fromJson(String json) {
    return ensureInitialized().decodeJson<PomodoroTask>(json);
  }
}

mixin PomodoroTaskMappable {
  String toJson() {
    return PomodoroTaskMapper.ensureInitialized()
        .encodeJson<PomodoroTask>(this as PomodoroTask);
  }

  Map<String, dynamic> toMap() {
    return PomodoroTaskMapper.ensureInitialized()
        .encodeMap<PomodoroTask>(this as PomodoroTask);
  }

  PomodoroTaskCopyWith<PomodoroTask, PomodoroTask, PomodoroTask> get copyWith =>
      _PomodoroTaskCopyWithImpl(this as PomodoroTask, $identity, $identity);
  @override
  String toString() {
    return PomodoroTaskMapper.ensureInitialized()
        .stringifyValue(this as PomodoroTask);
  }

  @override
  bool operator ==(Object other) {
    return PomodoroTaskMapper.ensureInitialized()
        .equalsValue(this as PomodoroTask, other);
  }

  @override
  int get hashCode {
    return PomodoroTaskMapper.ensureInitialized()
        .hashValue(this as PomodoroTask);
  }
}

extension PomodoroTaskValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PomodoroTask, $Out> {
  PomodoroTaskCopyWith<$R, PomodoroTask, $Out> get $asPomodoroTask =>
      $base.as((v, t, t2) => _PomodoroTaskCopyWithImpl(v, t, t2));
}

abstract class PomodoroTaskCopyWith<$R, $In extends PomodoroTask, $Out>
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
  PomodoroTaskCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PomodoroTaskCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PomodoroTask, $Out>
    implements PomodoroTaskCopyWith<$R, PomodoroTask, $Out> {
  _PomodoroTaskCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PomodoroTask> $mapper =
      PomodoroTaskMapper.ensureInitialized();
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
  PomodoroTask $make(CopyWithData data) => PomodoroTask(
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
  PomodoroTaskCopyWith<$R2, PomodoroTask, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PomodoroTaskCopyWithImpl($value, $cast, t);
}
