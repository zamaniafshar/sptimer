import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sptimer/common/widgets/neumorphic/background_container.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/routes/app_router.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/neumorphic/circle_neumorphic_button.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    required this.animation,
    required this.task,
    Key? key,
    this.isInitialAnimation = false,
  }) : super(key: key);

  final Animation<double> animation;
  final Task task;
  final bool isInitialAnimation;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: SizeTransition(
        sizeFactor: Tween<double>(
          begin: isInitialAnimation ? 1 : 0.5,
          end: 1,
        ).animate(animation),
        child: Slidable(
          key: ValueKey(task.id),
          useTextDirection: false,
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              _CustomSlidableAction(
                onPressed: onDelete,
                icon: Icons.delete,
                iconColor: Colors.red,
                backgroundColor: theme.colorScheme.surface,
                label: localization.tasksScreenDelete,
                textColor: Colors.red,
              ),
              _CustomSlidableAction(
                onPressed: onEdit,
                icon: Icons.edit,
                iconColor: Colors.green,
                backgroundColor: theme.colorScheme.surface,
                label: localization.tasksScreenEdit,
                textColor: Colors.green,
              ),
            ],
          ),
          child: BackgroundContainer(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.title,
                            style: theme.textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '1/${task.maxPomodoroRound}',
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      15.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _TaskInfoLabel(
                            title: localization.tasksScreenWorkTimePrefix,
                            minutes: task.workDuration.inMinutes,
                          ),
                          _TaskInfoLabel(
                            title: localization.tasksScreenShortBreakTimePrefix,
                            minutes: task.shortBreakDuration.inMinutes,
                          ),
                          _TaskInfoLabel(
                            title: localization.longBreakTimePrefix,
                            minutes: task.longBreakDuration.inMinutes,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                15.horizontalSpace,
                CircleNeumorphicButton(
                  radius: 50.r,
                  colors: [
                    theme.colorScheme.secondary,
                    theme.colorScheme.secondaryContainer,
                  ],
                  onTap: () => onStart(context),
                  icon: BlocBuilder<LocalizationCubit, Locale>(
                    builder: (context, state) {
                      return RotatedBox(
                        quarterTurns: state.isEnglish ? 0 : 2,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 25.r,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEdit(BuildContext context) {
    context.router.push(AddEditTaskRoute(task: task));
    Slidable.of(context)!.close();
  }

  void onDelete(BuildContext context) {
    context.read<TasksCubit>().delete(task.id!);
    Slidable.of(context)!.close();
  }

  void onStart(BuildContext context) {
    context.router.push(PomodoroTimerRoute(task: task));
    Slidable.of(context)!.close();
  }
}

class _CustomSlidableAction extends StatelessWidget {
  const _CustomSlidableAction({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    required this.iconColor,
  }) : super(key: key);

  final void Function(BuildContext context) onPressed;
  final IconData icon;
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Expanded(
      child: GestureDetector(
        onTap: () => onPressed(context),
        child: BackgroundContainer(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          padding: EdgeInsets.all(5.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 30.r,
              ),
              10.verticalSpace,
              Text(
                label,
                style: theme.textTheme.labelMedium!.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskInfoLabel extends StatelessWidget {
  const _TaskInfoLabel({
    Key? key,
    required this.title,
    required this.minutes,
  }) : super(key: key);

  final String title;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return Row(
      children: [
        Text(
          '$title : ',
          style: theme.primaryTextTheme.labelMedium,
        ),
        Text(
          '$minutes ${localization.tasksScreenTimeSuffix}',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
