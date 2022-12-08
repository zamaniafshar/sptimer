import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/utils/utils.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';

class TaskReportageWidget extends StatelessWidget {
  const TaskReportageWidget({Key? key, required this.task, required this.height}) : super(key: key);

  final PomodoroTaskReportageModel task;
  final double height;

  String convertDateToString(DateTime date, [bool showSuffix = true]) {
    String suffix = '';
    if (showSuffix) suffix = date.hour > 11 ? ' PM' : ' AM';
    final hour = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    return '$hour:$min$suffix';
  }

  List<Color> getColors(ThemeData theme) {
    if (task.taskStatus.isDone) {
      return [
        theme.colorScheme.secondary,
        theme.colorScheme.secondaryContainer,
      ];
    } else {
      return [
        theme.primaryColorLight,
        theme.primaryColorDark,
      ];
    }
  }

  String get statusText =>
      task.taskStatus.name[0].toUpperCase() + task.taskStatus.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.all(15.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            convertDateToString(task.startDate),
            style: theme.textTheme.bodyMedium,
          ),
          15.horizontalSpace,
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                gradient: getColors(theme).getLinearGradient,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: Color.fromARGB(24, 0, 0, 0),
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          task.taskName,
                          style: theme.textTheme.labelLarge!.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      5.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                        child: Text(
                          statusText,
                          style: theme.primaryTextTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Text(
                    '${convertDateToString(task.startDate, false)} - ${convertDateToString(task.endDate!)}',
                    style: theme.textTheme.bodySmall!.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
