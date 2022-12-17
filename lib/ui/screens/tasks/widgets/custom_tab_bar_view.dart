import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/localization/app_localization.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_controller.dart';
import 'package:pomotimer/ui/widgets/widgets.dart';

import 'task_info_widget.dart';

class CustomTabBarView extends StatelessWidget {
  CustomTabBarView({Key? key}) : super(key: key);

  final TasksController controller = Get.find();

  void startPomodoroTask(PomodoroTaskModel task, BuildContext context) {
    Get.find<MainController>().onPomodoroTaskStart(task);
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
    final appTexts = AppLocalization.of(context);
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
                  return ListError(appTexts.tasksScreenError);
                } else if (controller.allTasks.isEmpty &&
                    controller.isAnimatingInitialValues == false) {
                  return EmptyList(
                    size: 180.h,
                    assetIcon: 'assets/icons/task.svg',
                    tittle: appTexts.tasksScreenNoTasksTitle,
                    description: appTexts.tasksScreenNoTasksDescription,
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
                  return ListError(appTexts.tasksScreenError);
                } else if (controller.doneTasks.isEmpty) {
                  return EmptyList(
                    size: 180.h,
                    assetIcon: 'assets/icons/task.svg',
                    tittle: appTexts.tasksScreenNoDoneTasksTitle,
                    description: appTexts.tasksScreenNoDoneTasksDescription,
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
                  return ListError(appTexts.tasksScreenError);
                } else if (controller.remainedTasks.isEmpty) {
                  return EmptyList(
                    size: 180.h,
                    assetIcon: 'assets/icons/task.svg',
                    tittle: appTexts.tasksScreenNoRemainedTasksTitle,
                    description: appTexts.tasksScreenNoRemainedTasksDescription,
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
