import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/controller/tasks_controller.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/animated_theme_button.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/task_info_widget.dart';
import 'package:pomotimer/util/util.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

import 'widgets/custom_tab_bar.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  final TasksController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          bottom: const CustomTabBar(),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: [
                  theme.primaryColorLight,
                  theme.primaryColorDark,
                ].getLinearGradient,
              ),
              child: AnimatedThemeButton(
                radius: 40.r,
                showMoonAtFirst: true,
                onChange: (value) {
                  Get.find<ThemeManager>().toggleTheme();
                },
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: controller.tasks.length,
                itemExtent: 110,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return TaskInfoWidget(
                    task: task,
                    onCircleButtonPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.startPomodoroTaskScreen,
                        arguments: task,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(),
            SizedBox(),
            // ListView.builder(
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   itemCount: 4,
            //   itemExtent: 110,
            //   itemBuilder: (context, index) {
            //     return TaskInfoWidget();
            //   },
            // ),
            // ListView.builder(
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   itemCount: 2,
            //   itemExtent: 110,
            //   itemBuilder: (context, index) {
            //     return TaskInfoWidget();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
