import 'package:sptimer/data/enums/task_status.dart';

const _kTaskReportageId = 'kTaskReportageId';
const _kPomodoroTaskId = 'kPomodoroTaskId';
const _kStartDate = 'kStartDate';
const _kEndDate = 'kEndDate';
const _kTaskName = 'kTaskName';
const _kStatus = 'kStatus';

class PomodoroTaskReportageModel {
  PomodoroTaskReportageModel({
    this.id,
    this.endDate,
    required this.startDate,
    required this.taskStatus,
    required this.pomodoroTaskId,
    required this.taskName,
  });
  final int? id;
  final DateTime startDate;
  final DateTime? endDate;
  final TaskStatus taskStatus;
  final int pomodoroTaskId;
  final String taskName;

  PomodoroTaskReportageModel copyWith({
    int? id,
    int? pomodoroTaskId,
    DateTime? startDate,
    DateTime? endDate,
    String? taskName,
    TaskStatus? taskStatus,
  }) {
    return PomodoroTaskReportageModel(
      id: id ?? this.id,
      pomodoroTaskId: pomodoroTaskId ?? this.pomodoroTaskId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      taskName: taskName ?? this.taskName,
      taskStatus: taskStatus ?? this.taskStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _kTaskReportageId: id,
      _kPomodoroTaskId: pomodoroTaskId,
      _kStartDate: startDate.toString(),
      _kEndDate: endDate?.toString(),
      _kTaskName: taskName,
      _kStatus: taskStatus.index,
    };
  }

  factory PomodoroTaskReportageModel.fromMap(Map<dynamic, dynamic> map) {
    return PomodoroTaskReportageModel(
      id: map[_kTaskReportageId],
      pomodoroTaskId: map[_kPomodoroTaskId],
      startDate: DateTime.parse(map[_kStartDate]),
      endDate: map[_kEndDate] != null ? DateTime.parse(map[_kEndDate]) : null,
      taskName: map[_kTaskName],
      taskStatus: TaskStatus.values[map[_kStatus]],
    );
  }
}
