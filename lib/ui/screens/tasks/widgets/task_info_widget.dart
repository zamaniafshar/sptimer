import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

class TaskInfoWidget extends StatelessWidget {
  const TaskInfoWidget(
    this.task, {
    Key? key,
  }) : super(key: key);

  final PomodoroTaskModel task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(10.r),
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
              onTap: () {},
            ),
          ],
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
