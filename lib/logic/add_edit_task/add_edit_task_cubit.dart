import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sptimer/data/repositories/tasks_repository.dart';
import 'package:sptimer/data/models/task.dart';

part 'add_edit_task_state.dart';

final class AddEditTaskCubit extends Cubit<AddEditTaskState> {
  AddEditTaskCubit(this._tasksRepository) : super(AddEditTaskInitial());

  final TasksRepository _tasksRepository;

  Future<void> edit(Task task) async {
    if (state is AddEditTaskInProgress) return;

    emit(AddEditTaskInProgress());
    final result = await _tasksRepository.update(task);

    result.when(
      onSuccess: (_) => emit(AddEditTaskSuccess()),
      onFailure: (e) => emit(AddEditTaskFailure(e)),
    );
  }

  Future<void> add(Task task) async {
    if (state is AddEditTaskInProgress) return;

    emit(AddEditTaskInProgress());
    final result = await _tasksRepository.add(task);

    result.when(
      onSuccess: (_) => emit(AddEditTaskSuccess()),
      onFailure: (e) => emit(AddEditTaskFailure(e)),
    );
  }
}
