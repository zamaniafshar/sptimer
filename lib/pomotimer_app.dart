import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/app_life_cycle.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen.dart';

class PomoTimerApp extends StatelessWidget {
  const PomoTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLifeCycle(
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Get.find<ThemeManager>().theme,
          getPages: appRoutes,
          transitionDuration: const Duration(milliseconds: 300),
          defaultTransition: Transition.noTransition,
          initialRoute: RoutesName.baseScreen,
          builder: _builder,
        ),
      ),
    );
  }

  Widget _builder(context, widget) {
    ScreenUtil.init(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: widget!,
    );
  }
}
