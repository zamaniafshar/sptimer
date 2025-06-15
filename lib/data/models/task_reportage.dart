import 'package:sptimer/data/enums/task_status.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:sptimer/common/id_generator.dart';

part 'task_reportage.mapper.dart';

@MappableClass()
final class TaskReportage with TaskReportageMappable {
  TaskReportage({
    String? id,
    required this.endDate,
    required this.startDate,
    required this.taskStatus,
    required this.taskId,
    required this.taskTitle,
  }) : id = id ?? IdGenerator.generate();

  final String id;
  final String taskId;
  final DateTime startDate;
  final DateTime endDate;
  final TaskStatus taskStatus;
  final String taskTitle;

  factory TaskReportage.fromMap(Map<String, dynamic> map) => TaskReportageMapper.fromMap(map);
}
