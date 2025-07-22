import 'package:sptimer/data/models/task.dart';

abstract interface class GlobalEvent {}

final class TaskEditedEvent implements GlobalEvent {
  TaskEditedEvent(this.task);

  final Task task;
}

final class TaskAddedEvent implements GlobalEvent {
  TaskAddedEvent(this.task);

  final Task task;
}
