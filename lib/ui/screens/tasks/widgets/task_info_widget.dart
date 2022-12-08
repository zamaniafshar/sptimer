import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

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
    final sizeCurveTween = CurveTween(curve: Curves.easeOutQuart);
    final tweenOffset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);

    return Slidable(
      key: ValueKey(task.id),
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
            backgroundColor: Colors.red.shade100.withOpacity(0.7),
            label: 'delete',
            textColor: Colors.red,
          ),
          _CustomSlidableAction(
            onPressed: (context) {
              onEditPressed?.call();
              Slidable.of(context)!.close();
            },
            icon: Icons.edit,
            iconColor: Colors.green,
            backgroundColor: Colors.green.shade100..withOpacity(0.7),
            label: 'edit',
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
                padding: EdgeInsets.all(15.r),
                style: NeumorphicStyle(
                  color: theme.colorScheme.surface,
                  shadowLightColor: Colors.black12,
                  depth: 5,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(15.r),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
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
                                '${task.pomodoroRound}/${task.maxPomodoroRound}',
                                style: theme.textTheme.labelMedium,
                              ),
                            ],
                          ),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _TaskInfoLabel(
                                title: 'W',
                                minutes: task.workDuration.inMinutes,
                              ),
                              _TaskInfoLabel(
                                title: 'SB',
                                minutes: task.shortBreakDuration.inMinutes,
                              ),
                              _TaskInfoLabel(
                                title: 'LB',
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
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 25.r,
                      ),
                      onTap: onCircleButtonPressed ?? () {},
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
      child: GestureDetector(
        onTap: () => onPressed(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15.r),
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

    return Row(
      children: [
        Text(
          '$title : ',
          style: theme.primaryTextTheme.labelMedium,
        ),
        Text(
          '$minutes m',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
