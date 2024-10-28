// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'task_reportage.dart';

class TaskReportageMapper extends ClassMapperBase<TaskReportage> {
  TaskReportageMapper._();

  static TaskReportageMapper? _instance;
  static TaskReportageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TaskReportageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TaskReportage';

  static String _$id(TaskReportage v) => v.id;
  static const Field<TaskReportage, String> _f$id =
      Field('id', _$id, opt: true);
  static DateTime _$endDate(TaskReportage v) => v.endDate;
  static const Field<TaskReportage, DateTime> _f$endDate =
      Field('endDate', _$endDate);
  static DateTime _$startDate(TaskReportage v) => v.startDate;
  static const Field<TaskReportage, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static TaskStatus _$taskStatus(TaskReportage v) => v.taskStatus;
  static const Field<TaskReportage, TaskStatus> _f$taskStatus =
      Field('taskStatus', _$taskStatus);
  static String _$taskId(TaskReportage v) => v.taskId;
  static const Field<TaskReportage, String> _f$taskId =
      Field('taskId', _$taskId);
  static String _$taskTitle(TaskReportage v) => v.taskTitle;
  static const Field<TaskReportage, String> _f$taskTitle =
      Field('taskTitle', _$taskTitle);

  @override
  final MappableFields<TaskReportage> fields = const {
    #id: _f$id,
    #endDate: _f$endDate,
    #startDate: _f$startDate,
    #taskStatus: _f$taskStatus,
    #taskId: _f$taskId,
    #taskTitle: _f$taskTitle,
  };

  static TaskReportage _instantiate(DecodingData data) {
    return TaskReportage(
        id: data.dec(_f$id),
        endDate: data.dec(_f$endDate),
        startDate: data.dec(_f$startDate),
        taskStatus: data.dec(_f$taskStatus),
        taskId: data.dec(_f$taskId),
        taskTitle: data.dec(_f$taskTitle));
  }

  @override
  final Function instantiate = _instantiate;

  static TaskReportage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TaskReportage>(map);
  }

  static TaskReportage fromJson(String json) {
    return ensureInitialized().decodeJson<TaskReportage>(json);
  }
}

mixin TaskReportageMappable {
  String toJson() {
    return TaskReportageMapper.ensureInitialized()
        .encodeJson<TaskReportage>(this as TaskReportage);
  }

  Map<String, dynamic> toMap() {
    return TaskReportageMapper.ensureInitialized()
        .encodeMap<TaskReportage>(this as TaskReportage);
  }

  TaskReportageCopyWith<TaskReportage, TaskReportage, TaskReportage>
      get copyWith => _TaskReportageCopyWithImpl(
          this as TaskReportage, $identity, $identity);
  @override
  String toString() {
    return TaskReportageMapper.ensureInitialized()
        .stringifyValue(this as TaskReportage);
  }

  @override
  bool operator ==(Object other) {
    return TaskReportageMapper.ensureInitialized()
        .equalsValue(this as TaskReportage, other);
  }

  @override
  int get hashCode {
    return TaskReportageMapper.ensureInitialized()
        .hashValue(this as TaskReportage);
  }
}

extension TaskReportageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TaskReportage, $Out> {
  TaskReportageCopyWith<$R, TaskReportage, $Out> get $asTaskReportage =>
      $base.as((v, t, t2) => _TaskReportageCopyWithImpl(v, t, t2));
}

abstract class TaskReportageCopyWith<$R, $In extends TaskReportage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      DateTime? endDate,
      DateTime? startDate,
      TaskStatus? taskStatus,
      String? taskId,
      String? taskTitle});
  TaskReportageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TaskReportageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TaskReportage, $Out>
    implements TaskReportageCopyWith<$R, TaskReportage, $Out> {
  _TaskReportageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TaskReportage> $mapper =
      TaskReportageMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          DateTime? endDate,
          DateTime? startDate,
          TaskStatus? taskStatus,
          String? taskId,
          String? taskTitle}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (endDate != null) #endDate: endDate,
        if (startDate != null) #startDate: startDate,
        if (taskStatus != null) #taskStatus: taskStatus,
        if (taskId != null) #taskId: taskId,
        if (taskTitle != null) #taskTitle: taskTitle
      }));
  @override
  TaskReportage $make(CopyWithData data) => TaskReportage(
      id: data.get(#id, or: $value.id),
      endDate: data.get(#endDate, or: $value.endDate),
      startDate: data.get(#startDate, or: $value.startDate),
      taskStatus: data.get(#taskStatus, or: $value.taskStatus),
      taskId: data.get(#taskId, or: $value.taskId),
      taskTitle: data.get(#taskTitle, or: $value.taskTitle));

  @override
  TaskReportageCopyWith<$R2, TaskReportage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TaskReportageCopyWithImpl($value, $cast, t);
}
