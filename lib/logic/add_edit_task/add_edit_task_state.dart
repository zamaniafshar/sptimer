part of 'add_edit_task_cubit.dart';

@freezed
abstract class AddEditTaskState with _$AddEditTaskState {
  const factory AddEditTaskState({
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
    // UI state fields
    required bool isEditing,
    Object? error,
  }) = _AddEditTaskState;

  factory AddEditTaskState.initial(
    Task? task,
  ) =>
      AddEditTaskState(
        id: task?.id,
        title: task?.title ?? '',
        workDuration: task?.workDuration ?? Duration(minutes: 25),
        shortBreakDuration: task?.shortBreakDuration ?? Duration(minutes: 5),
        longBreakDuration: task?.longBreakDuration ?? Duration(minutes: 15),
        maxPomodoroRound: task?.maxPomodoroRound ?? 4,
        vibrate: task?.vibrate ?? false,
        tone: task?.tone ?? Tones.happyBells,
        toneVolume: task?.toneVolume ?? 1.0,
        statusVolume: task?.statusVolume ?? 1.0,
        readStatusAloud: task?.readStatusAloud ?? false,
        isEditing: task != null,
        error: null,
      );
}

extension on AddEditTaskState {
  Task toTask() {
    return Task(
      id: id,
      title: title,
      workDuration: workDuration,
      shortBreakDuration: shortBreakDuration,
      longBreakDuration: longBreakDuration,
      maxPomodoroRound: maxPomodoroRound,
      vibrate: vibrate,
      tone: tone,
      toneVolume: toneVolume,
      statusVolume: statusVolume,
      readStatusAloud: readStatusAloud,
    );
  }
}
