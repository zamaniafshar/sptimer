import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/ui/widgets/widgets.dart';

class TaskInfoWidget extends StatelessWidget {
  const TaskInfoWidget({
    required this.task,
    this.onCircleButtonPressed,
    this.onEditPressed,
    this.onDeletePressed,
    required this.animation,
    Key? key,
  }) : super(key: key);

  final Animation<double> animation;
  final PomodoroTaskModel task;
  final VoidCallback? onCircleButtonPressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalization.of(context);
    final sizeCurveTween = CurveTween(curve: Curves.easeOutQuart);
    final tweenOffset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);

    return Slidable(
      key: ValueKey(task.id),
      useTextDirection: false,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          _CustomSlidableAction(
            onPressed: (context) {
              onDeletePressed?.call();
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
              onEditPressed?.call();
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
      child: SlideTransition(
        position: tweenOffset.animate(animation),
        child: SizeTransition(
          axis: Axis.vertical,
          sizeFactor: sizeCurveTween.animate(animation),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: SizedBox(
              height: 105.h,
              child: Neumorphic(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                style: NeumorphicStyle(
                  color: theme.colorScheme.surface,
                  shadowDarkColor: theme.shadowColor.withOpacity(0.7),
                  shadowLightColor: theme.colorScheme.shadow.withOpacity(0.3),
                  intensity: 0.5,
                  depth: 5,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(15.r),
                  ),
                ),
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
                                localization.convertNumber(
                                  '${task.pomodoroRound}/${task.maxPomodoroRound}',
                                ),
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
                                title: localization.tasksScreenLongBreakTimePrefix,
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
                      onTap: onCircleButtonPressed ?? () {},
                      icon: RotatedBox(
                        quarterTurns: AppLocalization.ofParent(context).isEnglish ? 0 : 2,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 25.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
    final theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
        child: GestureDetector(
          onTap: () => onPressed(context),
          child: Neumorphic(
            style: NeumorphicStyle(
              shadowDarkColor: theme.shadowColor.withOpacity(0.7),
              shadowLightColor: theme.colorScheme.shadow.withOpacity(0.3),
              color: backgroundColor,
              depth: 5,
              intensity: 0.3,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(15.r),
              ),
            ),
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
    final theme = Theme.of(context);
    final localization = AppLocalization.of(context);

    return Row(
      children: [
        Text(
          '$title : ',
          style: theme.primaryTextTheme.labelMedium,
        ),
        Text(
          localization.convertNumber(
            '$minutes ${localization.tasksScreenTimeSuffix}',
          ),
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
