import 'package:sptimer/data/enums/task_status.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/common/id_generator.dart';

part 'task_reportage.freezed.dart';
part 'task_reportage.g.dart';

@freezed
abstract class TaskReportage with _$TaskReportage {
  const factory TaskReportage({
    String? id,
    required DateTime endDate,
    required DateTime startDate,
    required TaskStatus taskStatus,
    required String taskId,
    required String taskTitle,
  }) = _TaskReportage;

  factory TaskReportage.fromJson(Map<String, dynamic> json) => _$TaskReportageFromJson(json);
}
