import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/controller/app_settings_controller.dart';
import 'package:sptimer/config/localization/app_localization_data.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/ui/screens/tasks/tasks_controller.dart';
import 'package:sptimer/ui/screens/tasks/widgets/animated_theme_button.dart';
import 'package:get/get.dart';
import 'package:sptimer/utils/utils.dart';

import 'widgets/custom_tab_bar.dart';
import 'widgets/custom_tab_bar_view.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with AutomaticKeepAliveClientMixin {
  late final TasksController controller;
  final AppSettingsController appSettingsController = Get.find();
  late ThemeData theme;
  late AppLocalizationData localization;

  @override
  void initState() {
    controller = Get.find<TasksController>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    localization = AppLocalization.of(context);
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
          title: Text(localization.tasksScreenTitle),
          bottom: const CustomTabBar(),
          actions: [
            Center(
              child: MaterialButton(
                onPressed: Get.find<AppSettingsController>().toggleLocalization,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                minWidth: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: theme.primaryColorDark,
                    ),
                    3.horizontalSpace,
                    Text(
                      localization.locale.languageCode.capitalizeFirst!,
                      style: theme.primaryTextTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
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
                showMoonAtFirst: !appSettingsController.isDarkTheme,
                onChange: (value) {
                  appSettingsController.toggleTheme();
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
