import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sptimer/config/routes/routes_name.dart';
import 'package:sptimer/view/base/widgets/custom_bottom_navigation_bar.dart';
import 'package:sptimer/view/tasks/tasks_screen.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/view/base/widgets/ignore_battery_optimization_permission_dialog.dart';
import 'package:sptimer/view/base/widgets/notification_permission_dialog.dart';
import 'package:sptimer/common/widgets/circle_neumorphic_button.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final screens = const [
    TasksScreen(),
  ];

  final PageController pageController = PageController();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (await Permission.notification.isGranted == false) {
          await showNotificationPermissionDialog(context);
          await Permission.notification.request();
        }
        if (await Permission.ignoreBatteryOptimizations.isGranted == false) {
          await showIgnoreBatteryOptimizationPermissionDialog(context);
          await Permission.ignoreBatteryOptimizations.request();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onChange: (currentIndex) {
          pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 250),
            curve: Curves.linear,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircleNeumorphicButton(
        radius: 65.r,
        colors: [
          theme.primaryColorLight,
          theme.primaryColorDark,
        ],
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.r,
        ),
        onTap: () {
          Navigator.pushNamed(context, RoutesName.addPomodoroTaskScreen);
        },
      ),
    );
  }
}
