import 'dart:async';

import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/common/database/database.dart';
import 'package:sptimer/common/extensions/extensions.dart';

final class TasksReportageRepository {
  TasksReportageRepository(this._database);

  final AdvancedDatabase _database;

  Future<List<TaskReportage>> getTodayReportages() async {
    final today = DateTime.now();

    return getAllReportagesInDates(today, today);
  }

  Future<List<TaskReportage>> getAllReportagesInDates(
    DateTime start,
    DateTime end,
  ) async {
    final reportages = <TaskReportage>[];
    for (final result in _database.getAllReversed()) {
      final data = await result;

      final task = TaskReportage.fromJson(data);
      if (task.startDate.isBetweenDates(start, end)) {
        reportages.add(task);
      } else if (task.startDate.isBefore(start)) {
        break;
      }
    }

    return reportages;
  }

  Future<void> add(TaskReportage task) async {
    await _database.save(task.id, task.toJson());
  }

  Future<void> update(Task task) async {
    for (var result in _database.getAllReversed()) {
      final map = await result;
      final reportageTask = TaskReportage.fromJson(map);
      if (reportageTask.taskId == task.id) {
        await _database.save(
          task.id,
          reportageTask.copyWith(taskTitle: task.title).toJson(),
        );
      }
    }
  }

  Future<void> deleteTaskReportages(String taskId) async {
    for (var result in _database.getAllReversed()) {
      final map = await result;
      final task = TaskReportage.fromJson(map);
      if (task.taskId == taskId) {
        await _database.delete(task.id);
      }
    }
  }
}

extension on DateTime {
  bool isBetweenDates(DateTime start, DateTime end) {
    if (isInSameDay(end) || isInSameDay(start)) return true;
    if (isBefore(end) && isAfter(start)) return true;
    return false;
  }
}
