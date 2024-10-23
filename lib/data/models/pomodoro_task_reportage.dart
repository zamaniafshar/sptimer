import 'package:sptimer/data/enums/task_status.dart';

import 'package:dart_mappable/dart_mappable.dart';

part 'pomodoro_task_reportage.mapper.dart';

@MappableClass()
final class PomodoroTaskReportage with PomodoroTaskReportageMappable {
  const PomodoroTaskReportage({
    this.id,
    this.endDate,
    required this.startDate,
    required this.taskStatus,
    required this.pomodoroTaskId,
    required this.taskTitle,
  });

  final int? id;
  final DateTime startDate;
  final DateTime? endDate;
  final TaskStatus taskStatus;
  final int pomodoroTaskId;
  final String taskTitle;

  factory PomodoroTaskReportage.fromMap(Map<String, dynamic> map) =>
      PomodoroTaskReportageMapper.fromMap(map);
}
