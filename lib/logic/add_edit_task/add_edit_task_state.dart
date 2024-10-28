part of 'add_edit_task_cubit.dart';

sealed class AddEditTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AddEditTaskInitial extends AddEditTaskState {}

final class AddEditTaskInProgress extends AddEditTaskState {}

final class AddEditTaskFailure extends AddEditTaskState {
  AddEditTaskFailure(this.e);

  final Exception e;

  @override
  List<Object> get props => [e];
}

final class AddEditTaskSuccess extends AddEditTaskState {}
