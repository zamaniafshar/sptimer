import 'package:sptimer/data/enums/task_status.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:sptimer/utils/id_generator.dart';

part 'pomodoro_task_reportage.mapper.dart';

@MappableClass()
final class PomodoroTaskReportage with PomodoroTaskReportageMappable {
  PomodoroTaskReportage({
    String? id,
    required this.endDate,
    required this.startDate,
    required this.taskStatus,
    required this.pomodoroTaskId,
    required this.taskTitle,
  }) : id = id ?? IdGenerator.generate();

  final String id;
  final String pomodoroTaskId;
  final DateTime startDate;
  final DateTime endDate;
  final TaskStatus taskStatus;
  final String taskTitle;

  factory PomodoroTaskReportage.fromMap(Map<String, dynamic> map) =>
      PomodoroTaskReportageMapper.fromMap(map);
}
