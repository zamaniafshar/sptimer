part of 'add_edit_pomodoro_task_cubit.dart';

sealed class AddEditPomodoroTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AddEditPomodoroTaskInitial extends AddEditPomodoroTaskState {}

final class AddEditPomodoroTaskInProgress extends AddEditPomodoroTaskState {}

final class AddEditPomodoroTaskFailure extends AddEditPomodoroTaskState {
  AddEditPomodoroTaskFailure(this.e);

  final Exception e;

  @override
  List<Object> get props => [e];
}

final class AddEditPomodoroTaskSuccess extends AddEditPomodoroTaskState {}
