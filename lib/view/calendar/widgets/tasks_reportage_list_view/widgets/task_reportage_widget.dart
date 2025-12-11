import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/config/localization/app_localizations.dart';
import 'package:sptimer/data/models/task_reportage.dart';

class TaskReportageWidget extends StatelessWidget {
  const TaskReportageWidget({Key? key, required this.task, required this.height}) : super(key: key);

  final TaskReportage task;
  final double height;

  String convertDateToString(
    BuildContext context,
    DateTime date, [
    bool showSuffix = true,
  ]) {
    String suffix = '';
    final localization = AppLocalizations.of(context)!;
    if (showSuffix) {
      suffix = date.hour > 11 ? localization.afternoonSuffix : localization.morningSuffix;
    }
    final hour = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    return '$hour:$min$suffix';
  }

  List<Color> getColors(ThemeData theme) {
    if (task.taskStatus.isCompleted) {
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

  String statusText(AppLocalizations localization) {
    if (task.taskStatus.isCompleted) return localization.calendarScreenCompleted;
    return localization.calendarScreenUncompleted;
  }

  String reportTimeText(BuildContext context) {
    return '${convertDateToString(context, task.startDate, false)} - ${convertDateToString(context, task.endDate)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return Container(
      height: height,
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.all(15.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            convertDateToString(context, task.startDate),
            style: theme.textTheme.bodyMedium,
          ),
          15.horizontalSpace,
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.centerStart,
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
                          task.taskTitle,
                          style: theme.textTheme.labelLarge!.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      5.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          statusText(localization),
                          style: theme.primaryTextTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Text(
                    reportTimeText(context),
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
