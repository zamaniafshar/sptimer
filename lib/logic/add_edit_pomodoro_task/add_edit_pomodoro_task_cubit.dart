import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sptimer/data/repositories/pomodoro_tasks_repository.dart';
import 'package:sptimer/data/models/pomodoro_task.dart';

part 'add_edit_pomodoro_task_state.dart';

final class AddEditPomodoroTaskCubit extends Cubit<AddEditPomodoroTaskState> {
  AddEditPomodoroTaskCubit(this._pomodoroTasksRepository) : super(AddEditPomodoroTaskInitial());

  final PomodoroTasksRepository _pomodoroTasksRepository;

  Future<void> edit(PomodoroTask task) async {
    if (state is AddEditPomodoroTaskInProgress) return;

    emit(AddEditPomodoroTaskInProgress());
    final result = await _pomodoroTasksRepository.update(task);

    result.when(
      onSuccess: (_) => emit(AddEditPomodoroTaskSuccess()),
      onFailure: (e) => emit(AddEditPomodoroTaskFailure(e)),
    );
  }

  Future<void> add(PomodoroTask task) async {
    if (state is AddEditPomodoroTaskInProgress) return;

    emit(AddEditPomodoroTaskInProgress());
    final result = await _pomodoroTasksRepository.add(task);

    result.when(
      onSuccess: (_) => emit(AddEditPomodoroTaskSuccess()),
      onFailure: (e) => emit(AddEditPomodoroTaskFailure(e)),
    );
  }
}
