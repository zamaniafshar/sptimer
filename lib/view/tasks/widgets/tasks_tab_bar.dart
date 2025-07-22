import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/theme/app_colors.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class TasksTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: [
          theme.primaryColorLight,
          theme.primaryColorDark,
        ].getLinearGradient,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            blurRadius: 5,
            spreadRadius: 2,
            color: theme.shadowColor.withOpacity(0.2),
          ),
        ],
      ),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          final allTasksLength = state.tasks.length;
          final remainingTasksLength = state.remainingTasks.length;
          final completedTasksLength = state.completedTasks.length;

          return TabBar(
            labelStyle: TextStyle(fontSize: 15.sp),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white30,
            ),
            dividerColor: Colors.transparent,
            tabs: [
              TabBarLabel(
                label: localization.tasksScreenAll,
                suffix: '$allTasksLength',
              ),
              TabBarLabel(
                label: localization.tasksScreenRemain,
                suffix: '$remainingTasksLength',
              ),
              TabBarLabel(
                label: localization.tasksScreenDone,
                suffix: '$completedTasksLength',
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 50.h);
}

class TabBarLabel extends StatelessWidget {
  const TabBarLabel({
    Key? key,
    required this.label,
    required this.suffix,
  }) : super(key: key);

  final String label;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
          ),
          5.horizontalSpace,
          Container(
            width: 25.w,
            height: 25.w,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white.withOpacity(0.3),
            ),
            child: Text(
              suffix,
            ),
          ),
        ],
      ),
    );
  }
}
