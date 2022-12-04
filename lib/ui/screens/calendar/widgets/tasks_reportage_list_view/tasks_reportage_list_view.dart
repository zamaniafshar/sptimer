import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'tasks_reportage_list_view_controller.dart';
import 'widgets/separated_date.dart';
import 'widgets/task_reportage_widget.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

class TasksReportageListView extends StatelessWidget {
  const TasksReportageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<TasksReportageListViewController>(
      builder: (controller) {
        if (controller.state.isError) {
          return Text('error');
        } else if (controller.state.isInitialLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.state.isEmpty) {
          return Text('empty');
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
                    ? Alignment.center
                    : controller.state.isLoadingAtBottom
                        ? const Alignment(0.0, 0.8)
                        : Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.surface,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
