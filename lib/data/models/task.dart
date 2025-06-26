import 'package:sptimer/data/enums/tones.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/common/id_generator.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    String? id,
    required String title,
    required Duration workDuration,
    required Duration shortBreakDuration,
    required Duration longBreakDuration,
    required int maxPomodoroRound,
    required bool vibrate,
    required Tones tone,
    required double toneVolume,
    required double statusVolume,
    required bool readStatusAloud,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
