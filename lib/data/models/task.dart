import 'package:sptimer/data/enums/tones.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:sptimer/common/id_generator.dart';

part 'task.mapper.dart';

@MappableClass()
final class Task with TaskMappable {
  Task({
    String? id,
    required this.title,
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.maxPomodoroRound,
    required this.vibrate,
    required this.tone,
    required this.toneVolume,
    required this.statusVolume,
    required this.readStatusAloud,
  }) : id = id ?? IdGenerator.generate();

  final String id;
  final String title;
  final Duration workDuration;
  final Duration shortBreakDuration;
  final Duration longBreakDuration;
  final int maxPomodoroRound;
  final bool vibrate;
  final Tones tone;
  final double toneVolume;
  final double statusVolume;
  final bool readStatusAloud;

  factory Task.fromMap(Map<String, dynamic> map) => TaskMapper.fromMap(map);
}
