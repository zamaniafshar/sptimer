import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/base/widgets/custom_bottom_navigation_bar.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_screen.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final screens = [
    TasksScreen(),
  ];

  final index = 0.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: ObxValue(
        (value) => IndexedStack(
          index: index.value,
          children: screens,
        ),
        index,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onChange: (currentIndex) {
          index.value = currentIndex;
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
          Get.toNamed(RoutesName.addPomodoroTaskScreen);
        },
      ),
    );
  }
}
