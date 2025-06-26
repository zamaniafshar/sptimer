import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/circle_neumorphic_button.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    required this.task,
    required this.onStart,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  final Task task;
  final VoidCallback onStart;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return Slidable(
      key: ValueKey(task.id),
      useTextDirection: false,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          _CustomSlidableAction(
            onPressed: (context) {
              onDelete.call();
              Slidable.of(context)!.close();
            },
            icon: Icons.delete,
            iconColor: Colors.red,
            backgroundColor: theme.colorScheme.surface,
            label: localization.tasksScreenDelete,
            textColor: Colors.red,
          ),
          _CustomSlidableAction(
            onPressed: (context) {
              onEdit.call();
              Slidable.of(context)!.close();
            },
            icon: Icons.edit,
            iconColor: Colors.green,
            backgroundColor: theme.colorScheme.surface,
            label: localization.tasksScreenEdit,
            textColor: Colors.green,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: SizedBox(
          height: 105.h,
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
                onTap: onStart,
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
    );
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
        child: GestureDetector(
          onTap: () => onPressed(context),
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
