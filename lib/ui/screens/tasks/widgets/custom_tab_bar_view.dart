import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sptimer/controller/app_controller.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/config/routes/routes_name.dart';
import 'package:sptimer/ui/screens/tasks/tasks_controller.dart';
import 'package:sptimer/ui/widgets/widgets.dart';

import 'task_info_widget.dart';

class CustomTabBarView extends StatelessWidget {
  CustomTabBarView({Key? key}) : super(key: key);

  final TasksController controller = Get.find();

  void startPomodoroTask(PomodoroTaskModel task, BuildContext context) {
    Get.find<AppController>().onPomodoroTaskStart(task);
    Navigator.pushNamed(
      context,
      RoutesName.startPomodoroTaskScreen,
    );
  }

  void editTask(PomodoroTaskModel task, BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      RoutesName.addPomodoroTaskScreen,
      arguments: task,
    );
    if (result == null) return;
    controller.updateTask(result as PomodoroTaskModel);
  }

  Widget taskWidgetBuilder(
    BuildContext context,
    int index,
    List<PomodoroTaskModel> tasks,
    Animation<double> animation,
  ) {
    final task = tasks[index];
    return TaskInfoWidget(
      task: task,
      animation: animation,
      onCircleButtonPressed: () => startPomodoroTask(task, context),
      onDeletePressed: () => controller.deleteTask(task.id!),
      onEditPressed: () => editTask(task, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Stack(
          children: [
            Obx(
              () => AnimatedList(
                key: controller.allTasksListKey,
                initialItemCount: controller.allTasks.length,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemBuilder: (context, index, animation) =>
                    taskWidgetBuilder(context, index, controller.allTasks, animation),
              ),
            ),
            Obx(
              () {
                if (controller.allTasksListStatus.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.allTasksListStatus.isError) {
                  return ListError(localization.tasksScreenError);
                } else if (controller.allTasks.isEmpty &&
                    controller.isAnimatingInitialValues == false) {
                  return EmptyList(
                    size: 180.h,
                    assetIcon: 'assets/icons/task.svg',
                    tittle: localization.tasksScreenNoTasksTitle,
                    description: localization.tasksScreenNoTasksDescription,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        Stack(
          children: [
            Obx(
              () => AnimatedList(
                key: controller.doneTasksListKey,
                initialItemCount: controller.doneTasks.length,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemBuilder: (context, index, animation) =>
                    taskWidgetBuilder(context, index, controller.doneTasks, animation),
              ),
            ),
            Obx(
              () {
                if (controller.doneTasksListStatus.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.doneTasksListStatus.isError) {
                  return ListError(localization.tasksScreenError);
                } else if (controller.doneTasks.isEmpty) {
                  return EmptyList(
                    size: 180.h,
                    assetIcon: 'assets/icons/task.svg',
                    tittle: localization.tasksScreenNoDoneTasksTitle,
                    description: localization.tasksScreenNoDoneTasksDescription,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        Stack(
          children: [
            Obx(
              () => AnimatedList(
                key: controller.remainedTasksListKey,
                initialItemCount: controller.remainedTasks.length,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemBuilder: (context, index, animation) =>
                    taskWidgetBuilder(context, index, controller.remainedTasks, animation),
              ),
            ),
            Obx(
              () {
                if (controller.remainedTasksListStatus.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.remainedTasksListStatus.isError) {
                  return ListError(localization.tasksScreenError);
                } else if (controller.remainedTasks.isEmpty) {
                  return EmptyList(
                    size: 180.h,
                    assetIcon: 'assets/icons/task.svg',
                    tittle: localization.tasksScreenNoRemainedTasksTitle,
                    description: localization.tasksScreenNoRemainedTasksDescription,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
