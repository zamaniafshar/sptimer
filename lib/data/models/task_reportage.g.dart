// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_reportage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskReportage _$TaskReportageFromJson(Map<String, dynamic> json) =>
    _TaskReportage(
      id: json['id'] as String?,
      endDate: DateTime.parse(json['end_date'] as String),
      startDate: DateTime.parse(json['start_date'] as String),
      taskStatus: $enumDecode(_$TaskStatusEnumMap, json['task_status']),
      taskId: json['task_id'] as String,
      taskTitle: json['task_title'] as String,
    );

Map<String, dynamic> _$TaskReportageToJson(_TaskReportage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'end_date': instance.endDate.toIso8601String(),
      'start_date': instance.startDate.toIso8601String(),
      'task_status': _$TaskStatusEnumMap[instance.taskStatus]!,
      'task_id': instance.taskId,
      'task_title': instance.taskTitle,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.uncompleted: 'uncompleted',
  TaskStatus.completed: 'completed',
};
