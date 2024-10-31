import 'dart:async';

import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/utils/database.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/result.dart';

final class TasksReportageRepository {
  TasksReportageRepository(this._database);

  final Database _database;

  Future<Result<List<TaskReportage>, Exception>> getTodayReportages() async {
    final today = DateTime.now();

    return getAllReportagesInDates(today, today);
  }

  Future<Result<List<TaskReportage>, Exception>> getAllReportagesInDates(
    DateTime start,
    DateTime end,
  ) async {
    return Result.tryCatch(() async {
      final reportages = <TaskReportage>[];
      for (int i = _database.keys.length - 1; i >= 0; i--) {
        final key = _database.keys.elementAt(i);
        final data = await _database.get(key);
        final task = TaskReportage.fromMap(data);
        if (task.startDate.isBetweenDates(start, end)) {
          reportages.add(task);
        } else if (task.startDate.isBefore(start)) {
          break;
        }
      }
      return reportages;
    });
  }

  Future<Result<void, Exception>> add(TaskReportage task) async {
    return Result.tryCatch(() async {
      await _database.save(task.id, task.toMap());
    });
  }

  Future<Result<void, Exception>> update(Task task) async {
    return Result.tryCatch(() async {
      for (var key in _database.keys) {
        final map = await _database.get(key);
        final reportageTask = TaskReportage.fromMap(map);
        if (reportageTask.taskId == task.id) {
          await _database.update(
            key,
            reportageTask.copyWith(taskTitle: task.title).toMap(),
          );
        }
      }
    });
  }

  Future<Result<void, Exception>> deleteTaskReportages(String taskId) async {
    return Result.tryCatch(() async {
      for (var key in _database.keys) {
        final map = await _database.get(key);
        final task = TaskReportage.fromMap(map);
        if (task.taskId == taskId) {
          await _database.delete(key);
        }
      }
    });
  }
}

extension on DateTime {
  bool isBetweenDates(DateTime start, DateTime end) {
    if (isInSameDay(end) || isInSameDay(start)) return true;
    if (isBefore(end) && isAfter(start)) return true;
    return false;
  }
}
