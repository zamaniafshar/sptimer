import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_controller.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/tasks/widgets/animated_theme_button.dart';
import 'package:get/get.dart';
import 'package:pomotimer/utils/utils.dart';

import 'widgets/custom_tab_bar.dart';
import 'widgets/custom_tab_bar_view.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with AutomaticKeepAliveClientMixin {
  late final TasksController controller;
  late ThemeData theme;

  @override
  void initState() {
    controller = Get.find<TasksController>();
    super.initState();
  }

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
        resizeToAvoidBottomInset: false,
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
        body: CustomTabBarView(),
      ),
    );
  }
}
