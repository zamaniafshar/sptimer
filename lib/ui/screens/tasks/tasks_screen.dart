import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/animated_theme_button.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/task_info_widget.dart';
import 'package:pomotimer/util/util.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

import 'widgets/custom_tab_bar.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: 5,
              itemExtent: 110,
              itemBuilder: (context, index) {
                return TaskInfoWidget();
              },
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: 4,
              itemExtent: 110,
              itemBuilder: (context, index) {
                return TaskInfoWidget();
              },
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: 2,
              itemExtent: 110,
              itemBuilder: (context, index) {
                return TaskInfoWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
