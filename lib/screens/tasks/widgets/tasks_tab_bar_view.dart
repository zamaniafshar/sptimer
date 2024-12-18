import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/config/routes/routes_name.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';
import 'package:sptimer/screens/tasks/tasks_screen.dart';
import 'package:sptimer/utils/constants/assets.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/widgets/app_loading_widget.dart';
import 'package:sptimer/utils/widgets/empty_list_placeholder.dart';
import 'package:sptimer/utils/widgets/list_error.dart';

import 'task_widget.dart';

class TasksTabBarView extends StatelessWidget {
  const TasksTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadInProgress) {
          return AppLoadingWidget();
        } else if (state is TasksLoadFailure) {
          return AppFailureWidget(state.e);
        }

        (state as TasksLoadSuccess);

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _TasksTabBarView(
              tasks: state.tasks,
              emptyListPlaceholder: EmptyListPlaceholder(
                svgIcon: Assets.taskSvg,
                tittle: localization.tasksScreenNoTasksTitle,
                description: localization.tasksScreenNoTasksDescription,
              ),
            ),
            _TasksTabBarView(
              tasks: state.remainingTasks,
              emptyListPlaceholder: EmptyListPlaceholder(
                svgIcon: Assets.taskSvg,
                tittle: localization.tasksScreenNoRemainedTasksTitle,
                description: localization.tasksScreenNoRemainedTasksDescription,
              ),
            ),
            _TasksTabBarView(
              tasks: state.completedTasks,
              emptyListPlaceholder: EmptyListPlaceholder(
                svgIcon: Assets.taskSvg,
                tittle: localization.tasksScreenNoDoneTasksTitle,
                description: localization.tasksScreenNoDoneTasksDescription,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TasksTabBarView extends StatelessWidget {
  const _TasksTabBarView({
    super.key,
    required this.tasks,
    required this.emptyListPlaceholder,
  });

  final List<Task> tasks;
  final Widget emptyListPlaceholder;

  void startPomodoroTask(Task task, BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesName.startPomodoroTaskScreen,
      arguments: task,
    );
  }

  void editTask(Task task, BuildContext context) async {
    await Navigator.pushNamed(
      context,
      RoutesName.addPomodoroTaskScreen,
      arguments: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return emptyListPlaceholder;

    return ListView.builder(
      itemBuilder: (context, index) {
        final task = tasks[index];

        return TaskWidget(
          task: task,
          onStart: () => startPomodoroTask(task, context),
          onDelete: () => context.read<TasksCubit>().delete(task.id),
          onEdit: () => editTask(task, context),
        );
      },
    );
  }
}
