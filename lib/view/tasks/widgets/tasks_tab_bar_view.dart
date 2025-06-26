import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/routes/app_router.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';
import 'package:sptimer/common/constants/assets.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/app_loading_widget.dart';
import 'package:sptimer/common/widgets/empty_list_placeholder.dart';

import 'task_widget.dart';

class TasksTabBarView extends StatelessWidget {
  const TasksTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state.isLoading) {
          return AppLoadingWidget();
        }

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _TasksTabBarView(
              tasks: state.tasks,
              emptyListPlaceholder: EmptyListPlaceholder(
                svgIcon: Assets.taskSvg,
                tittle: localization.noTasksTitle,
                description: localization.noTasksDescription,
              ),
            ),
            _TasksTabBarView(
              tasks: state.remainingTasks,
              emptyListPlaceholder: EmptyListPlaceholder(
                svgIcon: Assets.taskSvg,
                tittle: localization.noRemainedTasksTitle,
                description: localization.noRemainedTasksDescription,
              ),
            ),
            _TasksTabBarView(
              tasks: state.completedTasks,
              emptyListPlaceholder: EmptyListPlaceholder(
                svgIcon: Assets.taskSvg,
                tittle: localization.noDoneTasksTitle,
                description: localization.noDoneTasksDescription,
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
    context.router.push(PomodoroTimerRoute(task: task));
  }

  void editTask(Task task, BuildContext context) async {
    await context.router.push(AddPomodoroTaskRoute(task: task));
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
          onDelete: () => context.read<TasksCubit>().delete(task.id!),
          onEdit: () => editTask(task, context),
        );
      },
    );
  }
}
