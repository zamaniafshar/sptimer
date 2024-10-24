// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pomodoro_task_reportage.dart';

class PomodoroTaskReportageMapper
    extends ClassMapperBase<PomodoroTaskReportage> {
  PomodoroTaskReportageMapper._();

  static PomodoroTaskReportageMapper? _instance;
  static PomodoroTaskReportageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PomodoroTaskReportageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PomodoroTaskReportage';

  static int? _$id(PomodoroTaskReportage v) => v.id;
  static const Field<PomodoroTaskReportage, int> _f$id =
      Field('id', _$id, opt: true);
  static DateTime? _$endDate(PomodoroTaskReportage v) => v.endDate;
  static const Field<PomodoroTaskReportage, DateTime> _f$endDate =
      Field('endDate', _$endDate, opt: true);
  static DateTime _$startDate(PomodoroTaskReportage v) => v.startDate;
  static const Field<PomodoroTaskReportage, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static TaskStatus _$taskStatus(PomodoroTaskReportage v) => v.taskStatus;
  static const Field<PomodoroTaskReportage, TaskStatus> _f$taskStatus =
      Field('taskStatus', _$taskStatus);
  static int _$pomodoroTaskId(PomodoroTaskReportage v) => v.pomodoroTaskId;
  static const Field<PomodoroTaskReportage, int> _f$pomodoroTaskId =
      Field('pomodoroTaskId', _$pomodoroTaskId);
  static String _$taskTitle(PomodoroTaskReportage v) => v.taskTitle;
  static const Field<PomodoroTaskReportage, String> _f$taskTitle =
      Field('taskTitle', _$taskTitle);

  @override
  final MappableFields<PomodoroTaskReportage> fields = const {
    #id: _f$id,
    #endDate: _f$endDate,
    #startDate: _f$startDate,
    #taskStatus: _f$taskStatus,
    #pomodoroTaskId: _f$pomodoroTaskId,
    #taskTitle: _f$taskTitle,
  };

  static PomodoroTaskReportage _instantiate(DecodingData data) {
    return PomodoroTaskReportage(
        id: data.dec(_f$id),
        endDate: data.dec(_f$endDate),
        startDate: data.dec(_f$startDate),
        taskStatus: data.dec(_f$taskStatus),
        pomodoroTaskId: data.dec(_f$pomodoroTaskId),
        taskTitle: data.dec(_f$taskTitle));
  }

  @override
  final Function instantiate = _instantiate;

  static PomodoroTaskReportage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PomodoroTaskReportage>(map);
  }

  static PomodoroTaskReportage fromJson(String json) {
    return ensureInitialized().decodeJson<PomodoroTaskReportage>(json);
  }
}

mixin PomodoroTaskReportageMappable {
  String toJson() {
    return PomodoroTaskReportageMapper.ensureInitialized()
        .encodeJson<PomodoroTaskReportage>(this as PomodoroTaskReportage);
  }

  Map<String, dynamic> toMap() {
    return PomodoroTaskReportageMapper.ensureInitialized()
        .encodeMap<PomodoroTaskReportage>(this as PomodoroTaskReportage);
  }

  PomodoroTaskReportageCopyWith<PomodoroTaskReportage, PomodoroTaskReportage,
          PomodoroTaskReportage>
      get copyWith => _PomodoroTaskReportageCopyWithImpl(
          this as PomodoroTaskReportage, $identity, $identity);
  @override
  String toString() {
    return PomodoroTaskReportageMapper.ensureInitialized()
        .stringifyValue(this as PomodoroTaskReportage);
  }

  @override
  bool operator ==(Object other) {
    return PomodoroTaskReportageMapper.ensureInitialized()
        .equalsValue(this as PomodoroTaskReportage, other);
  }

  @override
  int get hashCode {
    return PomodoroTaskReportageMapper.ensureInitialized()
        .hashValue(this as PomodoroTaskReportage);
  }
}

extension PomodoroTaskReportageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PomodoroTaskReportage, $Out> {
  PomodoroTaskReportageCopyWith<$R, PomodoroTaskReportage, $Out>
      get $asPomodoroTaskReportage =>
          $base.as((v, t, t2) => _PomodoroTaskReportageCopyWithImpl(v, t, t2));
}

abstract class PomodoroTaskReportageCopyWith<
    $R,
    $In extends PomodoroTaskReportage,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      DateTime? endDate,
      DateTime? startDate,
      TaskStatus? taskStatus,
      int? pomodoroTaskId,
      String? taskTitle});
  PomodoroTaskReportageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PomodoroTaskReportageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PomodoroTaskReportage, $Out>
    implements PomodoroTaskReportageCopyWith<$R, PomodoroTaskReportage, $Out> {
  _PomodoroTaskReportageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PomodoroTaskReportage> $mapper =
      PomodoroTaskReportageMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? endDate = $none,
          DateTime? startDate,
          TaskStatus? taskStatus,
          int? pomodoroTaskId,
          String? taskTitle}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (endDate != $none) #endDate: endDate,
        if (startDate != null) #startDate: startDate,
        if (taskStatus != null) #taskStatus: taskStatus,
        if (pomodoroTaskId != null) #pomodoroTaskId: pomodoroTaskId,
        if (taskTitle != null) #taskTitle: taskTitle
      }));
  @override
  PomodoroTaskReportage $make(CopyWithData data) => PomodoroTaskReportage(
      id: data.get(#id, or: $value.id),
      endDate: data.get(#endDate, or: $value.endDate),
      startDate: data.get(#startDate, or: $value.startDate),
      taskStatus: data.get(#taskStatus, or: $value.taskStatus),
      pomodoroTaskId: data.get(#pomodoroTaskId, or: $value.pomodoroTaskId),
      taskTitle: data.get(#taskTitle, or: $value.taskTitle));

  @override
  PomodoroTaskReportageCopyWith<$R2, PomodoroTaskReportage, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PomodoroTaskReportageCopyWithImpl($value, $cast, t);
}
