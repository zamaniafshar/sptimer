import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/home/widgets/animated_theme_button.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: const Text('PomoTimer'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: theme.appBarTheme.surfaceTintColor,
              child: AnimatedThemeButton(
                radius: 35.r,
                showMoonAtFirst: true,
                onChange: (value) {
                  Get.find<ThemeManager>().toggleTheme();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
