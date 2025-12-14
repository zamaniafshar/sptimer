import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sptimer/common/widgets/async/app_failure_widget.dart';
import 'package:sptimer/common/widgets/async/empty_list_placeholder.dart';
import 'package:sptimer/config/localization/app_localizations.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/logic/calendar/date_picker/date_time_utils.dart';
import 'package:sptimer/logic/calendar/tasks_reportage_list/tasks_reportage_list_cubit.dart';
import 'widgets/separated_date.dart';
import 'widgets/task_reportage_widget.dart';

class TasksReportageListView extends StatefulWidget {
  const TasksReportageListView({Key? key}) : super(key: key);

  @override
  State<TasksReportageListView> createState() => _TasksReportageListViewState();
}

class _TasksReportageListViewState extends State<TasksReportageListView> {
  bool _checkIsDateChanged(List<TaskReportage> reportages, int index) {
    if (index <= 0) return true;
    return !reportages[index].startDate.isInSameDay(reportages[index - 1].startDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<TasksReportageListCubit, TasksReportageListState>(
      builder: (context, state) {
        if (state.error != null) {
          return AppFailureWidget(
            e: state.error,
            onRetry: () => context.read<TasksReportageListCubit>().refresh(),
          );
        } else if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.reportages.isEmpty) {
          return EmptyListPlaceholder(
            iconSize: 150.h,
            svgIcon: 'assets/icons/report.svg',
            tittle: localization.calendarScreenEmptyListTitle,
            description: localization.calendarScreenEmptyListDescription,
          );
        }

        final reportages = state.reportages;

        return ScrollablePositionedList.builder(
          itemPositionsListener: context.read<TasksReportageListCubit>().itemPositionsListener,
          itemScrollController: context.read<TasksReportageListCubit>().itemScrollController,
          itemCount: reportages.length,
          itemBuilder: (context, index) {
            final task = reportages[index];
            Widget widget = TaskReportageWidget(
              task: task,
              height: 110.h,
            );

            if (_checkIsDateChanged(reportages, index + 1)) {
              widget = Column(
                children: [
                  widget,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SeparatedDate(
                      height: 50.h,
                      date: reportages[index + 1].startDate,
                    ),
                  ),
                ],
              );
            }

            final isLast = index == reportages.length - 1;
            if (state.isLoadingMore && isLast) {
              widget = Column(
                children: [
                  widget,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const CircularProgressIndicator(),
                  ),
                ],
              );
            }

            return widget;
          },
        );
      },
    );
  }
}
