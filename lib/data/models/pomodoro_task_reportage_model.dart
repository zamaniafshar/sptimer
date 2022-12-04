import 'package:pomotimer/data/enums/task_status.dart';

const _kId = 'kId';
const _kPomodoroTaskId = 'kPomodoroTaskId';
const _kStartDate = 'kStartDate';
const _kEndDate = 'kEndDate';
const _kTaskName = 'kTaskName';
const _kStatus = 'kStatus';

class PomodoroTaskReportageModel {
  PomodoroTaskReportageModel({
    this.id,
    required this.pomodoroTaskId,
    required this.startDate,
    required this.endDate,
    required this.taskName,
    required this.status,
  });
  final int? id;
  final int pomodoroTaskId;
  final DateTime startDate;
  final DateTime endDate;
  final String taskName;
  final TaskStatus status;

  PomodoroTaskReportageModel copyWith({
    int? id,
    int? pomodoroTaskId,
    DateTime? startDate,
    DateTime? endDate,
    String? taskName,
    TaskStatus? status,
  }) {
    return PomodoroTaskReportageModel(
      id: id ?? this.id,
      pomodoroTaskId: pomodoroTaskId ?? this.pomodoroTaskId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      taskName: taskName ?? this.taskName,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _kId: id,
      _kPomodoroTaskId: pomodoroTaskId,
      _kStartDate: startDate.millisecondsSinceEpoch,
      _kEndDate: endDate.millisecondsSinceEpoch,
      _kTaskName: taskName,
      _kStatus: status.index,
    };
  }

  factory PomodoroTaskReportageModel.fromMap(Map<dynamic, dynamic> map) {
    return PomodoroTaskReportageModel(
      id: map[_kId],
      pomodoroTaskId: map[_kPomodoroTaskId],
      startDate: DateTime.fromMillisecondsSinceEpoch(map[_kStartDate]),
      endDate: DateTime.fromMillisecondsSinceEpoch(map[_kEndDate]),
      taskName: map[_kTaskName],
      status: TaskStatus.values[map[_kStatus]],
    );
  }
}
