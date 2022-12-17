import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/localization/app_localization.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';
import 'tasks_reportage_list_view_controller.dart';
import 'widgets/separated_date.dart';
import 'widgets/task_reportage_widget.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

class TasksReportageListView extends StatelessWidget {
  const TasksReportageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTexts = AppLocalization.of(context);

    return GetBuilder<TasksReportageListViewController>(
      builder: (controller) {
        if (controller.state.isError) {
          return ListError(appTexts.calendarScreenError);
        } else if (controller.state.isInitialLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.tasks.isEmpty) {
          return EmptyList(
            size: 150.h,
            assetIcon: 'assets/icons/report.svg',
            tittle: appTexts.calendarScreenEmptyListTitle,
            description: appTexts.calendarScreenEmptyListDescription,
          );
        }
        return Stack(
          children: [
            SizedBox.expand(
              child: FlutterListView(
                controller: controller.scrollController,
                delegate: FlutterListViewDelegate(
                  (context, index) {
                    final int itemIndex = index ~/ 2;

                    if (index.isEven) {
                      final task = controller.tasks[itemIndex];
                      return TaskReportageWidget(
                        task: task,
                        height: controller.taskWidgetsHeight,
                      );
                    }
                    if (controller.checkIsDateChanged(itemIndex + 1)) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: SeparatedDate(
                          height: controller.separatedWidgetsHeight,
                          date: controller.tasks[itemIndex + 1].startDate,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                  childCount: controller.itemCount,
                ),
              ),
            ),
            if (controller.state.isLoaded == false)
              Align(
                alignment: controller.state.isLoadingAtCenter
                    ? AlignmentDirectional.center
                    : controller.state.isLoadingAtBottom
                        ? const AlignmentDirectional(0.0, 0.8)
                        : AlignmentDirectional.topCenter,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.surface,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
