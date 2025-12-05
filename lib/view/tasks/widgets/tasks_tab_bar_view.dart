import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sptimer/common/widgets/keep_alive_wrapper.dart';
import 'package:sptimer/config/routes/app_router.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';
import 'package:sptimer/common/constants/assets.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/async/app_loading_widget.dart';
import 'package:sptimer/common/widgets/async/empty_list_placeholder.dart';

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
            KeepAliveWrapper(
              child: _TasksTabBarView(
                listModel: state.tasks,
                emptyListPlaceholder: EmptyListPlaceholder(
                  svgIcon: Assets.taskSvg,
                  tittle: localization.noTasksTitle,
                  description: localization.noTasksDescription,
                ),
              ),
            ),
            KeepAliveWrapper(
              child: _TasksTabBarView(
                listModel: state.remainingTasks,
                emptyListPlaceholder: EmptyListPlaceholder(
                  svgIcon: Assets.taskSvg,
                  tittle: localization.noRemainedTasksTitle,
                  description: localization.noRemainedTasksDescription,
                ),
              ),
            ),
            KeepAliveWrapper(
              child: _TasksTabBarView(
                listModel: state.completedTasks,
                emptyListPlaceholder: EmptyListPlaceholder(
                  svgIcon: Assets.taskSvg,
                  tittle: localization.noDoneTasksTitle,
                  description: localization.noDoneTasksDescription,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TasksTabBarView extends StatefulWidget {
  const _TasksTabBarView({
    super.key,
    required this.listModel,
    required this.emptyListPlaceholder,
  });

  final ListModel listModel;
  final Widget emptyListPlaceholder;

  @override
  State<_TasksTabBarView> createState() => _TasksTabBarViewState();
}

class _TasksTabBarViewState extends State<_TasksTabBarView> {
  bool isInitialAnimation = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isInitialAnimation = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listModel.items.isEmpty) {
      return widget.emptyListPlaceholder;
    }

    return AnimatedList(
      key: widget.listModel.listKey,
      initialItemCount: 0,
      itemBuilder: (context, index, animation) {
        final task = widget.listModel[index];

        return TaskWidget(
          animation: animation,
          task: task,
          isInitialAnimation: isInitialAnimation,
        );
      },
    );
  }
}
