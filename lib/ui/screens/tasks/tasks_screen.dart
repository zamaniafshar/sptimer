import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_controller.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/animated_theme_button.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/task_info_widget.dart';
import 'package:pomotimer/util/util.dart';

import 'widgets/custom_tab_bar.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with AutomaticKeepAliveClientMixin {
  final TasksController controller = Get.find();
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      Get.put(StartPomodoroTaskScreenController()).init(task);
                      Navigator.pushNamed(
                        context,
                        RoutesName.startPomodoroTaskScreen,
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
