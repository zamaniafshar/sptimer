import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'pomodoro_task_model.dart';

const _pomodoroTaskModelKey = 'pomodoroTaskModel';
const _pomodoroTaskReportageModel = 'pomodoroTaskReportageModel';

class PomodoroAppSateData {
  PomodoroAppSateData({
    required this.pomodoroTaskModel,
    this.pomodoroTaskReportageModel,
  });
  final PomodoroTaskModel pomodoroTaskModel;
  final PomodoroTaskReportageModel? pomodoroTaskReportageModel;

  PomodoroAppSateData copyWith({
    PomodoroTaskModel? pomodoroTaskModel,
    PomodoroTaskReportageModel? pomodoroTaskReportageModel,
  }) {
    return PomodoroAppSateData(
      pomodoroTaskModel: pomodoroTaskModel ?? this.pomodoroTaskModel,
      pomodoroTaskReportageModel: pomodoroTaskReportageModel ?? this.pomodoroTaskReportageModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _pomodoroTaskModelKey: pomodoroTaskModel.toMap(),
      _pomodoroTaskReportageModel: pomodoroTaskReportageModel?.toMap(),
    };
  }

  factory PomodoroAppSateData.fromMap(Map<dynamic, dynamic> map) {
    return PomodoroAppSateData(
      pomodoroTaskModel: PomodoroTaskModel.fromMap(map[_pomodoroTaskModelKey]),
      pomodoroTaskReportageModel: map[_pomodoroTaskReportageModel] != null
          ? PomodoroTaskReportageModel.fromMap(map[_pomodoroTaskReportageModel])
          : null,
    );
  }
}
